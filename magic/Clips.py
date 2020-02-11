import expyriment as xpy
import os, random

# set path
path_1 = r'S:/Murty_Group/users/Karen/CuriosityProject/Stim'

exp = xpy.control.initialize()

# set trigger
scan_trigger = xpy.misc.constants.K_EQUALS
trigger = exp.keyboard
list_of_videos = os.listdir(path_1)

xpy.stimuli.TextLine("Starting...").present()
trigger.wait(scan_trigger)

for n in range(len(list_of_videos)):
	stim = list_of_videos[n]
	v = xpy.stimuli.Video(os.path.join(path_1,stim))
	v.preload()

	v.play()
	v.present()
	video_presentation_time = exp.clock.time
	v.wait_end()
	v.stop()