/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.data.collections.IndexedArray;

class vo.Photos extends IndexedArray
{
	private var __current:Number = 0;
	
	public function Photos()
	{
	}
	
	public function getNext():String
	{
		// fix this
		return this[++__current].gphoto.id;
	}
	
	public function getPrevious():String
	{
		// fix this
		return this[--__current].gphoto.id;
	}
}