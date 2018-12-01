import notify2
import time
import sys
import os

os.environ.setdefault('XAUTHORITY', '/home/erik/.Xauthority')
os.environ.setdefault('DISPLAY', ':0.0')

seconds = int(sys.argv[1])
notify2.init("Rest")
notice = notify2.Notification("\t\t\t\t\t\tRest Warning", "\t\t\t\t\t\t{0} Seconds Left".format(seconds))
try:
	notice.set_urgency(notify2.URGENCY_LOW)
	notice.show()
	notice.set_timeout(3000)
	while seconds:
		if seconds <= 10:
			notice.set_urgency(notify2.URGENCY_CRITICAL)
			notice.update(summary="Rest Warning",message="{0} Seconds Left".format(seconds))
			notice.show()
		seconds-=1
		time.sleep(1)
	notice.close()
except KeyboardInterrupt:
	notice.close()
	exit