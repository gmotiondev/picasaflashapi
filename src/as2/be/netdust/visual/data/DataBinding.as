/** * Copyright (c) 2007 Stefan Vandermeulen - netdust.be 
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
import com.bourre.commands.Delegate;
import com.bourre.core.IAccessor;
class be.netdust.visual.data.DataBinding 
{
	public var source:IAccessor;
	public var target:IAccessor;
	public var property:String;
	
	
	public var register:Number;
	
	/**
	* @method  Constructor
	*/
	public function DataBinding( _oSource:IAccessor, _sProp:String, _oTarget:IAccessor )  
	{
		
        source = _oSource;
		target = _oTarget;
		property = _sProp;
		
		register = 0;
    };
	

	public function execute( prop, oldvalue, newvalue ) 
	{		
		target.setValue ( newvalue[property] );
		return newvalue;
	};
	
	public function destroy( ):Void 
	{
		delete this;
	};
	

    public static function initBinding( binding:DataBinding ) : DataBinding 
	{
		
		var _oDelegate:Function = Delegate.create( binding, binding["execute"] )
		
		binding.source.getTarget().watch( binding.source.getGetterHelper(),
										  _oDelegate,
										  binding
								   );
							   
		binding.register = 1;
		return (binding);
    } 
	

	public static function addBinding(source:IAccessor, prop:String, target:IAccessor) : DataBinding 
	{
		var databind:DataBinding = new DataBinding( source, prop, target );		
		return initBinding( databind );		
	};

}