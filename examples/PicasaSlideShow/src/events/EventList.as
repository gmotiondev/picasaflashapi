import com.bourre.events.EventType;

/**
  @author Michal Gron (michal.gron@gmail.com)
 */
class events.EventList
{ 
	public static var RUN_APPLICATION:EventType = new EventType("RunApplication");	public static var SERVICE_LOADED:EventType = new EventType("ServiceLoaded");	public static var PHOTO_THUMB_CLICK:EventType = new EventType("PhotoThumbClick");
	public static var ON_PREV_PHOTO:EventType = new EventType("OnPrevPhoto");
	public static var ON_NEXT_PHOTO:EventType = new EventType("OnNextPhoto");
}