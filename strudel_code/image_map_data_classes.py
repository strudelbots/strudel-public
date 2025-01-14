import logging # STRUDEL_IMPORT_0
import json
import re
import sys
import uuid
from dataclasses import dataclass, field

from dataclasses_json import dataclass_json


strudel = logging.getLogger(__name__) # STRUDEL_IMPORT_1
strudel.addHandler(logging.StreamHandler()) # STRUDEL_IMPORT_2
strudel.setLevel(logging.INFO) # STRUDEL_IMPORT_3
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
            strudel.info(f' Return None because "release_tag" is evaluated to False') #  # STRUDEL_IF_LOG_1
            return None
        for release in self.release_details:
            if release.release_tag == release_tag:
                if len(release.image) > 1:
                    raise ValueError(f"Multiple images found for tag: {release_tag}")
                return release.image[0]
    def find_tag(self, input_tag):
        for tag_details in self.release_details:
            if tag_details.release_tag == input_tag:
                return tag_details
        strudel.info('Method "find_tag" returns') #  # STRUDEL_RETURN_TRACE_0
        return None


def verify_release_tag(tag):
    if tag == 'run-entire-repository':
        tag =  "v0.22.02" # TODO - generalize
    match = re.match(r"v0\.[0-9]{1,2}\.[0-9]{1,2}", tag)
    if not match:
        strudel.error(' Raise ValueError( ** Invalid release tag:   . . .) because "match" is evaluated to False') #  # STRUDEL_IF_LOG_1
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
    strudel.info('Method "load_current_map" returns "map_class"') #  # STRUDEL_RETURN_TRACE_0
    return map_class

