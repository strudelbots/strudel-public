import json
import re
import sys
import uuid
from dataclasses import dataclass, field

from dataclasses_json import dataclass_json


@dataclass_json
@dataclass
class ImageDetails:
    tag: str
    added_date: str
    id: uuid = uuid.uuid4().hex.upper()[0:6]


@dataclass_json
@dataclass
class SingleReleaseToImageMap:
    release_tag: str
    image: list[ImageDetails]


@dataclass_json
@dataclass
class ImageMap:
    release_details: list[SingleReleaseToImageMap] = field(default_factory=list)
    def save(self):
        with open(map_file, 'w') as f:
            json.dump(self.to_dict(), f, indent=4)
    def find_image(self, release_tag):
        if not release_tag:
            return None
        for release in self.release_details:
            if release.release_tag == release_tag:
                if len(release.image) > 1:
                    raise ValueError(f"Multiple images found for tag: {release_tag}")
                return release.image[0]
        return None
    def add_image(self, image_details):
        pass
    def find_tag(self, input_tag):
        for tag_details in self.release_details:
            if tag_details.release_tag == input_tag:
                return tag_details
        return None


def verify_release_tag(tag):
    match = re.match(r"v0\.[0-9]{1,2}\.[0-9]{1,2}", tag)
    if not match:
        raise ValueError(f" ** Invalid release tag: {tag} **")


map_file = "release_to_image_map.json"


def load_current_map():
    try:
        with open(map_file, 'r') as f:
            map = json.load(f)
    except Exception as e:
        print(f"Error loading map file: {map_file}, printing error: {e}", file=sys.stderr)
        raise
    json_string = json.dumps(map)
    map_class = ImageMap.from_json(json_string)
    return map_class
