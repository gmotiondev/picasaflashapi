/*
 * The MIT License
 * 
 * Copyright (c) 2008 Michal Gron (michal.gron@gmail.com)
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

package sk.prasa.webapis.picasa.objects 
{
/**
 * @private
 */
public class Utils
{
	/**
	 * Parses node content as a string. if node is empty, returns null.
	 * 
	 * @param value XMLList node
	 * @return parsed node content as String
	 */
	public static function parseString(value : XMLList) : String
	{
		var tRes : String;
			tRes = value ? value[0] : null;
			
		return trim(tRes).length != 0 ? tRes : null;
	}
	
	/**
	 * Parses node content as a number. if node is empty, returns NaN.
	 * 
	 * @param value XMLList node
	 * @return parsed node content as Number 
	 */
	public static function parseNumber(value : XMLList) : Number
	{
		var tRes : String;
			tRes = Utils.parseString(value);
		
		return parseFloat(tRes);
	}
	
	/**
	 * Parses node content as unsigned integer. if node is empty, returns zero.
	 * 
	 * @param value XMLList node 
	 * @return parsed node content as uint
	 */
	public static function parseUint(value : XMLList) : uint
	{
		var tRes : String;
			tRes = Utils.parseString(value);
			
		return parseInt(tRes) as uint;
	}
	
	/**
	 * Parses node content as boolean value. if node is empty, returns false, 
	 * true otherwise.
	 * 
	 * @param value XMLList node
	 * @return parsed node content as boolean value
	 */
	public static function parseBoolean(value : XMLList) : Boolean
	{
		var tRes : String;
			tRes = Utils.parseString(value);
		
		switch(tRes)
		{
			case "1":
			case "true":
				return true;
				
			default: 
				return false;
		}
	}
	
	/**
	 * Parses node content as date value according to date parsing function.
	 * 
	 * @param value XMLList node with date string (RFC 3339)
	 * @param func date parsing Function
	 */
	public static function parseDate(value : XMLList, func : Function) : Date
	{
		var tRes : String = Utils.parseString(value);
		var tDate : Date;
		 
		try
		{
			tDate = (tRes != null) ? func(tRes) : null;
		}
		catch(e : Error)
		{
			tDate = null;
		}
		finally
		{
			return tDate;	
		}
	}
	
	/** 
	 * Date parsing function used in conjuction with parseDate method.
	 * 
	 * @param str date as string (RFC 3339)
	 * @return native AS3 date object
	 */
	public static function parseW3CDTF(str : String) : Date
	{
		var finalDate : Date;
		
		try
		{
			var dateStr : String = str.substring(0, str.indexOf("T"));
			var timeStr : String = str.substring(str.indexOf("T") + 1, str.length);
			var dateArr : Array = dateStr.split("-");
			var year : Number = Number(dateArr.shift());
			var month : Number = Number(dateArr.shift());
			var date : Number = Number(dateArr.shift());
			
			var multiplier : Number;
			var offsetHours : Number;
			var offsetMinutes : Number;
			var offsetStr : String;
			
			if (timeStr.indexOf("Z") != -1)
			{
				multiplier = 1;
				offsetHours = 0;
				offsetMinutes = 0;
				timeStr = timeStr.replace("Z", "");
			}
			else if (timeStr.indexOf("+") != -1)
			{
				multiplier = 1;
				offsetStr = timeStr.substring(timeStr.indexOf("+") + 1, timeStr.length);
				offsetHours = Number(offsetStr.substring(0, offsetStr.indexOf(":")));
				offsetMinutes = Number(offsetStr.substring(offsetStr.indexOf(":") + 1, offsetStr.length));
				timeStr = timeStr.substring(0, timeStr.indexOf("+"));
			}
			else // offset is -
			{
				multiplier = -1;
				offsetStr = timeStr.substring(timeStr.indexOf("-") + 1, timeStr.length);
				offsetHours = Number(offsetStr.substring(0, offsetStr.indexOf(":")));
				offsetMinutes = Number(offsetStr.substring(offsetStr.indexOf(":") + 1, offsetStr.length));
				timeStr = timeStr.substring(0, timeStr.indexOf("-"));
			}
			
			var timeArr : Array = timeStr.split(":");
			var hour : Number = Number(timeArr.shift());
			var minutes : Number = Number(timeArr.shift());
			var secondsArr : Array = (timeArr.length > 0) ? String(timeArr.shift()).split(".") : null;
			var seconds : Number = (secondsArr != null && secondsArr.length > 0) ? Number(secondsArr.shift()) : 0;
			var milliseconds : Number = (secondsArr != null && secondsArr.length > 0) ? Number(secondsArr.shift()) : 0;
			var utc : Number = Date.UTC(year, month - 1, date, hour, minutes, seconds, milliseconds);
			var offset : Number = (((offsetHours * 3600000) + (offsetMinutes * 60000)) * multiplier);
			
			finalDate = new Date(utc - offset);

			if (finalDate.toString() == "Invalid Date")
			{
				throw new Error("This date does not conform to W3CDTF.");
			}
		}
		catch (e : Error)
		{
			var eStr : String = "Unable to parse the string [" + str + "] into a date. ";
				eStr += "The internal error was: " + e.toString();
				
			throw new Error(eStr);
		}
		
		return finalDate;
	}
	
	// Note: The following code was copied from Flash Remoting's
	// NetServices client components.
	// It is reproduced here to keep the services APIs
	// independent of the deprecated NetServices code.
	// Note that it capitalizes any use of URL in method or class names.

	/**
	 * Determines if the URL uses the HTTP, HTTPS, or RTMP protocol. 
	 *
	 * @param url The URL to analyze.
	 * @return <code>true</code> if the URL starts with "http://", "https://", or "rtmp://".
	 */
	public static function isHttpURL(url : String) : Boolean
	{
		return 	 url != null &&
				(url.indexOf("http://") == 0 ||
			 	 url.indexOf("https://") == 0);
	}
	
	/**
	 * Removes all whitespace characters from the beginning and end
	 * of the specified string.
	 *
	 * @param str The String whose whitespace should be trimmed. 
	 * @return Updated String where whitespace was removed from the 
	 * beginning and end.
	 * 
	 * @private BORROWED FROM FLEX SDK (3.2.03958) TO LOOSE DEPENDENCIES ON SDK 
	 */
	private static function trim(str:String):String
	{
		if (str == null) return '';
		
		var startIndex:int = 0;
		while (isWhitespace(str.charAt(startIndex)))
			++startIndex;
		
		var endIndex:int = str.length - 1;
		
		while (isWhitespace(str.charAt(endIndex)))
			--endIndex;
		
		if (endIndex >= startIndex)
			return str.slice(startIndex, endIndex + 1);
		else
			return "";
	}
	
	/**
	 * Returns <code>true</code> if the specified string is
	 * a single space, tab, carriage return, newline, or formfeed character.
	 *
	 * @param str The String that is is being queried.
	 * @return <code>true</code> if the specified string is
	 * a single space, tab, carriage return, newline, or formfeed character.
	 * @private BORROWED FROM FLEX SDK (3.2.03958) TO LOOSE DEPENDENCIES ON SDK 
	 */
	private static function isWhitespace(character : String) : Boolean
	{
		switch (character)
		{
			case " ":
			case "\t":
			case "\r":
			case "\n":
			case "\f":
					return true;
				
				default:
					return false;
		}
	}
}
}