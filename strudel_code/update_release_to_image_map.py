import json
import re
import sys
import uuid
from dataclasses import dataclass, field
from datetime import datetime

from dataclasses_json import dataclass_json

from strudel_code.image_map_data_classes import map_file, ImageMap, ImageDetails, SingleReleaseToImageMap, \
    verify_release_tag, load_current_map


#map_file = "release_to_image_map.json"
# @dataclass_json
# @dataclass
# class ImageDetails:
#     tag: str
#     added_date: str
#     id: uuid = uuid.uuid4().hex.upper()[0:6]
# @dataclass_json
# @dataclass
# class SingleReleaseToImageMap:
#     release_tag: str
#     image: list[ImageDetails]
#
# @dataclass_json
# @dataclass
# class ImageMap:
#     release_details: list[SingleReleaseToImageMap] = field(default_factory=list)
#     def save(self):
#         with open(map_file, 'w') as f:
#             json.dump(self.to_dict(), f, indent=4)
#     def find_image(self, tag):
#         pass
#     def add_image(self, image_details):
#         pass
#     def find_tag(self, input_tag):
#         for tag_details in self.release_details:
#             if tag_details.release_tag == input_tag:
#                 return tag_details
#         return None
# def load_current_map():
#     try:
#         with open(map_file, 'r') as f:
#             map = json.load(f)
#     except Exception as e:
#         print(f"Error loading map file: {map_file}, printing error: {e}")
#         sys.exit(1)
#     json_string = json.dumps(map)
#     map_class = ImageMap.from_json(json_string)
#     return map_class


def update_release_to_image_map(release_tag, image_tag, date):
    map = load_current_map()
    image_details = ImageDetails(image_tag, date)
    current_tag = map.find_tag(release_tag)
    if current_tag:
        raise Exception(f"Tag {release_tag} already exists in the map")
    else:
        new_tag = SingleReleaseToImageMap(release_tag, [image_details])
        map.release_details.append(new_tag)
        map.save()
    


def validate_image_tag(image_tag):
    match = re.match(r"v-[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}-b-[0-9]{1,5}", image_tag)
    if not match:
        print(f"Invalid image tag: {image_tag}")
        sys.exit(1)


if __name__ == '__main__':
    try:
        release_tag = sys.argv[1]
        image_tag = sys.argv[2]
    except IndexError:
        print("Usage: python update_release_to_image_map.py <tag> <added_date>")
        sys.exit(1)
    verify_release_tag(release_tag)
    validate_image_tag(image_tag)
    date_time = datetime.now().strftime("%m/%d/%Y, %H:%M:%S")

    update_release_to_image_map(release_tag, image_tag, date_time)