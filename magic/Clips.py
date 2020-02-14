import expyriment as xpy
import os, random,time, numpy

# set path
path_1 = r'S:/Murty_Group/users/Karen/CuriosityProject/Stim'
os.chdir('S:/Murty_Group/users/Karen/CuriosityProject/Data')

exp = xpy.control.initialize()
xpy.control.start(skip_ready_screen = True)
subData = []
subID = exp.subject
textinput = xpy.io.TextInput(message = "group")
group = textinput.get()

# set trigger
scan_trigger = xpy.misc.constants.K_EQUALS
trigger = exp.keyboard
#list_of_videos = os.listdir(path_1)
if group == "1": #H L L H L L L H L L H H L H H L H H L H L H
	list_of_videos = ['K23.mp4','S30.mp4','K30.mp4','S32.mp4','K9.mp4','Trick38.mp4','K24.mp4','S9.mp4','H36.mp4','Trick14_Long.mp4','K2.mp4','H16.mp4','S21.mp4','K4.mp4','H7.mp4','S28.mp4','S27.mp4','K1.mp4','H2.mp4','H18.mp4','K13.mp4','H10.mp4']
elif group == "2": #L H H L H H H L H H L L H L L H L L H L H L 
	list_of_videos = ['Trick14_Long.mp4','H7.mp4','K1.mp4','H2.mp4','K4.mp4','H18.mp4','H10.mp4','S21.mp4','S27.mp4','K23.mp4','K13.mp4','H36.mp4','S9.mp4','S28.mp4','K24.mp4','K2.mp4','K9.mp4','K30.mp4','S32.mp4','S30.mp4','H16.mp4','Trick38.mp4']


xpy.stimuli.TextLine("Starting...").present()
trigger.wait(scan_trigger)
start_time = time.time()

for n in range(len(list_of_videos)):
	stim = list_of_videos[n]
	v = xpy.stimuli.Video(os.path.join(path_1,stim))
	v.preload()
	v.play()
	v.present()
	start = time.time()
	start = start - start_time
	video_presentation_time = exp.clock.time
	v.wait_end()
	v.stop()
	end = time.time()
	end = end - start_time
	d = [stim,start,end]
	subData.append(d)

	Data = numpy.asarray(subData)
	filename = "timing_sub"+str(subID)+".csv"
	xpy.misc.data_preprocessing.write_csv_file(str(filename),Data,varnames = ['stim','start','end'],delimiter=', ')
		