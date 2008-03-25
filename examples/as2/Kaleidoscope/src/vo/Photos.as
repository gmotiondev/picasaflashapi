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
	public function getCurrentUrl():String
	{
		return this[__current].media.content.url;
	}
}