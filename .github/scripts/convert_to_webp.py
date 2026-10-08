#!/usr/bin/env python3
"""Generate .webp copies of PNG/JPEG images and point HTML/CSS at them.

For every image `foo.png` a sibling `foo.png.webp` is created (or refreshed
when the source is newer). Image references in .html and .css files are then
rewritten to the .webp copy. Originals are kept, and <link>/<meta> tags
(favicons, apple-touch-icon, tile images) are left alone because those
consumers expect PNG.
"""

import os
import re
import subprocess
import sys
from urllib.parse import urlsplit

ROOT = os.path.abspath(sys.argv[1] if len(sys.argv) > 1 else ".")
SITE_HOSTS = {"will-ch-h.github.io", "www.will-ch-h.github.io"}
SKIP_DIRS = {".git", ".github", "node_modules"}
IMAGE_EXTS = (".png", ".jpg", ".jpeg")

IMAGE_URL = re.compile(
    r"""(?P<url>[^\s"'(),<>]+?\.(?:png|jpe?g))(?P<tail>[?#][^\s"'(),<>]*)?(?=[\s"'),<>]|$)""",
    re.IGNORECASE,
)
PROTECTED_TAG = re.compile(r"<(?:link|meta)\b[^>]*>", re.IGNORECASE)


def walk(exts):
    for dirpath, dirnames, filenames in os.walk(ROOT):
        dirnames[:] = [d for d in dirnames if d not in SKIP_DIRS]
        for name in filenames:
            if name.lower().endswith(exts):
                yield os.path.join(dirpath, name)


def convert_images():
    converted = 0
    for src in walk(IMAGE_EXTS):
        dst = src + ".webp"
        if os.path.exists(dst) and os.path.getmtime(dst) >= os.path.getmtime(src):
            continue
        result = subprocess.run(
            ["cwebp", "-quiet", "-q", "85", "-alpha_q", "100", "-m", "6",
             "-metadata", "icc", src, "-o", dst],
            capture_output=True, text=True,
        )
        if result.returncode != 0:
            print(f"::warning file={os.path.relpath(src, ROOT)}::cwebp failed: {result.stderr.strip()}")
            continue
        converted += 1
        print(f"converted {os.path.relpath(src, ROOT)}")
    return converted


def resolve(url, file_dir):
    """Map an image URL to a path on disk, or None if it is not ours."""
    parts = urlsplit(url)
    if parts.scheme in ("http", "https") or url.startswith("//"):
        if parts.hostname not in SITE_HOSTS:
            return None
        path = parts.path
    elif parts.scheme:
        return None
    else:
        path = url
    if path.startswith("/"):
        return os.path.join(ROOT, path.lstrip("/"))
    return os.path.normpath(os.path.join(file_dir, path))


def rewrite_segment(text, file_dir):
    def sub(m):
        disk = resolve(m.group("url"), file_dir)
        if disk and os.path.isfile(disk + ".webp"):
            return m.group("url") + ".webp" + (m.group("tail") or "")
        return m.group(0)
    return IMAGE_URL.sub(sub, text)


def rewrite_references():
    changed = 0
    for path in walk((".html", ".htm", ".css")):
        with open(path, encoding="utf-8", errors="surrogateescape") as f:
            original = f.read()
        file_dir = os.path.dirname(path)
        if path.lower().endswith(".css"):
            updated = rewrite_segment(original, file_dir)
        else:
            out, pos = [], 0
            for tag in PROTECTED_TAG.finditer(original):
                out.append(rewrite_segment(original[pos:tag.start()], file_dir))
                out.append(tag.group(0))
                pos = tag.end()
            out.append(rewrite_segment(original[pos:], file_dir))
            updated = "".join(out)
        if updated != original:
            with open(path, "w", encoding="utf-8", errors="surrogateescape") as f:
                f.write(updated)
            changed += 1
            print(f"rewrote {os.path.relpath(path, ROOT)}")
    return changed


if __name__ == "__main__":
    images = convert_images()
    pages = rewrite_references()
    print(f"{images} image(s) converted, {pages} file(s) rewritten")
