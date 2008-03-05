import com.bourre.data.libs.ILibListener;
import com.bourre.events.EventType;
import com.bourre.data.libs.IXMLToObjectDeserializer;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

interface sk.prasa.webapis.generic.IXMLService
{
	public function load(sURL : String) : Void;
	
	public function getPerCent() : Number;
	public function getURL() : String;
	public function setURL(sURL:String) : Void;
	public function addListener( oL : ILibListener ) : Void;
	public function removeListener( oL : ILibListener ) : Void;
	
	public function getName() : String;
	public function setName( sURL : String ) : Void;
	
	public function setAntiCache( b : Boolean ) : Void;
	public function prefixURL( sURL : String ) : Void;
	
	public function setDeserializer ( deserializer : IXMLToObjectDeserializer ) : Void;
	public function getDeserializer() : IXMLToObjectDeserializer;

	public function addEventListener(e : EventType, oL, f : Function) : Void;
	public function removeEventListener(e : EventType, oL) : Void;
}
