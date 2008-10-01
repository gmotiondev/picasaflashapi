import org.papervision3d.objects.Plane;

import com.bourre.events.BasicEvent;

import control.Controller;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class control.ChangeCameraExtraEvent extends BasicEvent
{
	public var target : Object;
	public var plane : Plane;

	public function ChangeCameraExtraEvent(aTarget : Object, aPlane : Plane)
	{
		super(Controller.CHANGE_CAMERA_EXTRA_EVENT);
		
		target = aTarget;
		plane = aPlane;
	}
}
