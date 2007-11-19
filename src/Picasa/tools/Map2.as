/**
 * Deprecated, will be deleted
 */
 import com.bourre.data.collections.Map;
import Picasa.tools.ObjectIterator2;

class Picasa.tools.Map2 extends Map
{
	/**
	 * Constructor, initialize extended object
	 */
	public function Map2()
	{ 
		super();
	}
	/**
	 * override getKeysIterator and returns custom ObjectIterator2
	 * @return custom ObjectIterator2 iterator
	 */
	public function getKeysIterator():ObjectIterator2
	{
		return new ObjectIterator2(_oV);
	}
	/**
	 * override getValuesIterator and returns custom ObjectIterator2
	 * @return custom ObjectIterator2
	 */
	public function getValuesIterator():ObjectIterator2
	{
		return new ObjectIterator2(_oK);
	}
}
