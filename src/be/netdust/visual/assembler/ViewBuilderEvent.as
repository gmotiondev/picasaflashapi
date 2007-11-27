﻿/** * Copyright (c) 2007 Stefan Vandermeulen - netdust.be 
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
import com.bourre.events.BasicEvent;
import com.bourre.events.EventType;
import  be.netdust.visual.assembler.ViewBuilder;


class be.netdust.visual.assembler.ViewBuilderEvent 
	extends BasicEvent
{
	private var _o : ViewBuilder;
	private var _i;
	
	public function ViewBuilderEvent( e : EventType, o : ViewBuilder, i ) 
	{
		super( e );
		
		_o = o;
		_i = i;
	}
	
	public function getViewLoader() : ViewBuilder
	{
		return _o;
	}
	
	public function getInstance() 
	{
		return _i;
	}

	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance
	 */
	public function toString() : String 
	{
		return "be.netdust.visual.assembler.ViewBuilderEvent ";
	}
}