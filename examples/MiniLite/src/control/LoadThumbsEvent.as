/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class control.LoadThumbsEvent 
{
	public var thumbs : Array;
	public var type : String = "load_thumbs_event";
	
	public function LoadThumbsEvent(aThumbs : Array)
	{
		thumbs = aThumbs;
	}
}
