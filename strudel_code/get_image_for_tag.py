import sys

from strudel_code.image_map_data_classes import verify_release_tag, load_current_map


def get_image_for_tag(release_tag):
    map = load_current_map()
    return map.find_image(release_tag)


if __name__ == '__main__':
    try:
        release_tag = sys.argv[1]
    except IndexError:
        print("Usage: python update_release_to_image_map.py <version_tag>" , sys.stderr)
        sys.exit(1)
    verify_release_tag(release_tag)
    image_tag = get_image_for_tag(release_tag)
    if not image_tag:
        print(f"Image tag not found for release tag: {release_tag}", sys.stderr)
        sys.exit(1)
    print(image_tag.tag)
