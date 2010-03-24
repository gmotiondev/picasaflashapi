package mainSuite.cases.objects
{
import net.digitalprimates.fluint.tests.TestCase;

import sk.prasa.webapis.picasa.objects.Utils;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 * 
 * // todo: missing some other Utils method like parseBoolean, parseUint 
 */
public class TestUtils extends TestCase 
{
	public function testParseString() : void
	{
		var tNull : XML = <root></root>;
		var tEmpty : XML = <root><value/></root>;
		var tSimple : XML = <root><value>this is string</value></root>;
		var tComplex : XML = <root id="someid">
								<value>first value</value>
								<value>second value</value>
								<value>third value</value>
							</root>;
		var tString : String;
		 
		// node not found		
		tString = Utils.parseString(tNull.value);
		assertEquals("nullxml.value length is zero", tNull.value.length(), 0);
		assertNull("is null, because nullxml.value zero is 0", tString);
		
		// empty node found
		tString = Utils.parseString(tEmpty.value);
		assertEquals("emptyxml.value is empty string", tEmpty.value, "");
		assertNull("is null, because nullxml.value is empty", tString);
		
		// simple node found
		tString = Utils.parseString(tSimple.value);
		assertTrue("simple is xml list", tSimple.value is XMLList);
		assertTrue("s) is string", tString is String);
		assertEquals(tString, "this is string");
		
		// nodes collection found
		tString = Utils.parseString(tComplex.value);
		assertTrue("complex is xml list", tComplex.value is XMLList);
		assertTrue("c) is string", tString is String);
		assertEquals(tString, "first value");
		
		// null passed
		tString = Utils.parseString(null);
		assertEquals(tString, null);
	}

	public function testParseNumber() : void
	{
		var tNull : XML = <root></root>;
		var tEmpty : XML = <root><value/></root>;
		var tStringSimple : XML = <root><value>this is string</value></root>;
		var tNumberSimple : XML = <root><value>10</value></root>;
		var tComplex : XML = <root id="someid">
								<value>123.456</value>
								<value>second value</value>
								<value>third value</value>
							</root>;
		var tNumber : Number; 
		
		// node not found
		tNumber = Utils.parseNumber(tNull.value);
		assertEquals("null.value length is zero", tNull.value.length(), 0);
		assertTrue("NaN, because nullxml.value zero is 0", isNaN(tNumber));
		
		// empty node found
		tNumber = Utils.parseNumber(tEmpty.value);
		assertEquals("empty.value is empty string", tEmpty.value, "");
		assertTrue("NaN, because empty.value is empty", isNaN(tNumber));
		
		// simple string node found
		tNumber = Utils.parseNumber(tStringSimple.value);
		assertTrue("NaN because it's unparsable string", isNaN(tNumber));
		
		// simple number node found
		tNumber = Utils.parseNumber(tNumberSimple.value);
		assertEquals(tNumber, 10);
		
		// nodes collection found
		tNumber = Utils.parseNumber(tComplex.value);
		assertTrue("complex is xml list", tComplex.value is XMLList);
		assertEquals(tNumber, 123.456);
		
		// null passed
		tNumber = Utils.parseNumber(null);
		assertTrue(isNaN(tNumber));
	}
	
	public function testParseDate() : void
	{
		var tCorrect : XML = <root><value>2007-08-11T14:38:51.000Z</value></root>;
		var tIncorrect : XML = <root><value>0000-incorrect-date-000Z</value></root>;
		var tEmpty : XML = <root></root>;
		var tDate : Date; 
		
		// correct
		tDate = Utils.parseDate(tCorrect.value, Utils.parseW3CDTF);
		assertEquals(tDate.toUTCString(), "Sat Aug 11 14:38:51 2007 UTC");
		
		// incorrect
		tDate = Utils.parseDate(tIncorrect.value, Utils.parseW3CDTF);
		assertNull(tDate);
		
		// null
		tDate = Utils.parseDate(tEmpty.value, Utils.parseW3CDTF);
		assertNull(tDate);
	}
}
}
