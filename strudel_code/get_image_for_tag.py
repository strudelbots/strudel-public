import sys

from strudel_code.image_map_data_classes import verify_release_tag, load_current_map


#v0.13.02
def get_image_for_tag(release_tag):
    if release_tag == 'main':
        release_tag =  "0.14.02" # TODO - generalize
    map = load_current_map()
    result = map.find_image(release_tag)
    if not result:
        for entry in map.release_details:
            if release_tag.startswith(entry.release_tag):
#                strudel.info(f"Found release tag: {release_tag}")
                return entry.image[0]
    return result


if __name__ == '__main__':
    try:
        release_tag = sys.argv[1]
    except IndexError:
        print("Usage: python update_release_to_image_map.py <version_tag>" , file=sys.stderr)
        sys.exit(1)
    try:
        verify_release_tag(release_tag)
    except Exception as e:
        print(f"  ****  invalid tag '{release_tag}' ****", file=sys.stderr)
        print("no-tag-found", file=sys.stdout)
        sys.exit(0)
    image_tag = get_image_for_tag(release_tag)
    if not image_tag:
        print(f"Image tag not found for release tag: {release_tag}", file=sys.stderr)
        print("no-tag-found", file=sys.stdout)
    else:
        print(image_tag.tag, file=sys.stdout)





