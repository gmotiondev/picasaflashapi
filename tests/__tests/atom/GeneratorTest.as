package atom
{
	import flexunit.framework.TestCase;

	import sk.prasa.webapis.picasa.objects.Generator;	
	
	public class GeneratorTest extends TestCase 
	{
		private const URI : String = "http://picasaweb.google.com/";
		private const VALUE : String = "Picasaweb";
		private const VERSION : String = "1.00"; 

		public function GeneratorTest(methodName : String = null)
		{
			super(methodName);
		}	

		public function testURI() : void
		{
			var tGenerator : Generator = new Generator();
				tGenerator.value = URI;
			
			assertNotNull("tGenerator.value is null", tGenerator.value);
			assertTrue("tGenerator.value == URI", tGenerator.value == URI);
		}

		public function testValue() : void
		{
			var tGenerator : Generator = new Generator();
				tGenerator.value = VALUE;
			
			assertNotNull("tGenerator.value is null", tGenerator.value);
			assertTrue("tGenerator.value == VALUE", tGenerator.value == VALUE);
		}

		public function testVersion() : void
		{
			var tGenerator : Generator = new Generator();
				tGenerator.version = VERSION;
			
			assertNotNull("tGenerator.version is null", tGenerator.version);
			assertTrue("tGenerator.version == VERSION", tGenerator.version == VERSION);
		}		
	}
}