#1/bin/bash
source ../venv/bin/activate
cd /home/shai/strudel-public/strudel_code
export PYTHONPATH="/home/shai/strudel-public/"
echo $PYTHONPATH
#python ../strudel_code/get_image_for_tag.py v0.10.11
output=$(python ../strudel_code/get_image_for_tag.py v0.10.11)
echo
echo "output:$output"
if [[ $output = "no-tag-found" ]]; then
	echo "test 1 passed"
else
	echo "*** test 1 failed ***"
	exit 1
fi
output=$(python ../strudel_code/get_image_for_tag.py v0.10.21)
echo
echo "output:$output"
if [[ $output = "v-0.0.1-b-1" ]]; then
	echo "test 2 passed"
else
	echo "*** test 2 failed ***"
	exit 1
fi
output=$(python ../strudel_code/get_image_for_tag.py abc)
echo
echo "output:$output"
if [[ $output = "no-tag-found" ]]; then
	echo "test 3 passed"
else
	echo "*** test 3 failed ***"
	exit 1
fi
output=$(python ../strudel_code/get_image_for_tag.py v0.11.11)
echo
echo "output:$output"
if [[ $output = "v-0.0.2-b-2" ]]; then
	echo "test 4 passed"
else
	echo "*** test 4 failed ***"
	exit 1
fi
output=$(python ../strudel_code/get_image_for_tag.py v0.11.11-hotfix)
echo
echo "output:$output"
if [[ $output = "v-0.0.2-b-2" ]]; then
	echo "test 5 passed"
else
	echo "*** test 5 failed ***"
	exit 1
fi
output=$(python ../strudel_code/get_image_for_tag.py v0.11.12-hotfix)
echo
echo "output:$output"
if [[ $output = "no-tag-found" ]]; then
	echo "test 5 passed"
else
	echo "*** test 5 failed ***"
	exit 1
fi
