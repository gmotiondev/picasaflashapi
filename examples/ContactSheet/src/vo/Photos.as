/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.data.collections.IndexedArray;

class vo.Photos extends IndexedArray
{
	private var __current:Number;
	
	// 
	public function Photos()
	{
	}
	
	// 
	public function getNext():String
	{
		if(++__current >= this.length || __current == null) __current = 0;
		return this[__current].gphoto.id;
	}
	
	// 
	public function getPrevious():String
	{
		if(--__current < 0) __current = this.length - 1;
		return this[__current].gphoto.id;
	}
	
	// 
	public function getCurrentTitle():String
	{
		return "ss"+(typeof(this[__current].summary) == "string" ? this[__current].summary : "___");
	}
	
	// 
	public function getClicked(aId:String):String
	{
		__current = getIndexById(aId);
		
		return aId;
	}
	
	private function getIndexById(aId:String):Number
	{
		for(var a:Number = 0; a < this.length; a++)
		{
			if(this[a].gphoto.id == aId) return getIndex(this[a]);
		}
		
		return 0;
	}
}