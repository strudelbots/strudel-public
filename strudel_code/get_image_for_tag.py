import sys

from strudel_code.image_map_data_classes import verify_release_tag, load_current_map


def get_image_for_tag(release_tag):
    map = load_current_map()
    return map.find_image(release_tag)


if __name__ == '__main__':
    try:
        release_tag = sys.argv[1]
    except IndexError:
        print("Usage: python update_release_to_image_map.py <version_tag>" , file=sys.stderr)
        sys.exit(1)
    try:
        verify_release_tag(release_tag)
    except ValueError as e:
        print(f"  ****  invalid tag '{release_tag}' ****", file=sys.stderr)
        print("no-tag-found", file=sys.stdout)
        sys.exit(0)
    image_tag = get_image_for_tag(release_tag)
    if not image_tag:
        print(f"Image tag not found for release tag: {release_tag}", file=sys.stderr)
        print("no-tag-found", file=sys.stdout)
    else:
        print(image_tag.tag, file=sys.stdout)
