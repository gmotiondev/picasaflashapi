import com.bourre.data.collections.IndexedArray;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class vo.Photos extends IndexedArray
{
	private var __current : Number;
	private static var __instance : Photos;
	
	/**
	 * Singleton
	 */
	private function Photos()
	{
	}
	
	/**
	 * 
	 */
	public static function getInstance() : Photos
	{
		if(!__instance) __instance = new Photos();
		return __instance;
	}

	/**
	 * 
	 */ 
	public function getNext() : String
	{
		if(++__current >= this.length || __current == null) __current = 0;
		return this[__current].gphoto.id;
	}
	
	/**
	 * 
	 */ 
	public function getPrevious() : String
	{
		if(--__current < 0) __current = this.length - 1;
		return this[__current].gphoto.id;
	}
	
	/**
	 * 
	 */ 
	public function getCurrentTitle() : String
	{
		return this[__current].summary;
	}
	
	/**
	 * 
	 */ 
	public function getCurrentUrl() : String
	{
		return this[__current].media.content.url;
	}
	
	/**
	 * 
	 */
	public function getCurrentId() : String
	{
		return this[__current].gphoto.id;
	}
	
	/**
	 * 
	 */ 
	public function setClicked(aId:String) : Void
	{
		__current = getIndexById(aId);
	}
	
	/**
	 * 
	 */ 
	private function getIndexById(aId:String) : Number
	{
		for(var a:Number = 0; a < this.length; a++)
		{
			if(this[a].gphoto.id == aId) return getIndex(this[a]);
		}
		
		return 0;
	}
}