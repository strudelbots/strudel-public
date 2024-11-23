import logging # STRUDEL_IMPORT_0
import sys

from strudel_code.image_map_data_classes import verify_release_tag, load_current_map


#v0.13.02
strudel = logging.getLogger(__name__) # STRUDEL_IMPORT_1
strudel.addHandler(logging.StreamHandler()) # STRUDEL_IMPORT_2
strudel.setLevel(logging.INFO) # STRUDEL_IMPORT_3
def get_image_for_tag(release_tag):
    map = load_current_map()
    result = map.find_image(release_tag)
    if not result:
        strudel.info(' "result" is evaluated to False') #  # STRUDEL_IF_LOG_0
        for entry in map.release_details:
            if release_tag.startswith(entry.release_tag):
#                strudel.info(f"Found release tag: {release_tag}")
                return entry.image[0]
    strudel.info('Method "get_image_for_tag" returns "result"') #  # STRUDEL_RETURN_TRACE_0
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




