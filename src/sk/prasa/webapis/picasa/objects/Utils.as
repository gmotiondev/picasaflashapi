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
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 * @private
	 */
	public class Utils
	{
		public static function parseString(xmllist : XMLList) : String
		{
			var tString : String = String(xmllist);
			
			if (trim(tString).length == 0)
			{
				return null;
			}
			
			return tString;
		}
		
		public static function parseNumber(xmllist : XMLList) : Number
		{
			var tString : String = String(xmllist);
			
			if(Utils.parseString(xmllist) == null || tString.search(/\d/) == -1)
			{
				return NaN;
			}
			
			return Number(tString);
		}
		
		public static function parseDate(xmllist : XMLList, f : Function) : Date
		{
			var tString : String = String(xmllist);
			
			if (Utils.parseString(xmllist) == null)
			{
				return null;
			}
			
			return f(tString);
		}

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
			} catch (e : Error)
			{
				var eStr : String = "Unable to parse the string [" + str + "] into a date. ";
					eStr += "The internal error was: " + e.toString();
					
				throw new Error(eStr);
			}
			
			return finalDate;
		}
		
		/**
		 *  Removes all whitespace characters from the beginning and end
		 *  of the specified string.
		 *
		 *  @param str The String whose whitespace should be trimmed. 
		 *
		 *  @return Updated String where whitespace was removed from the 
		 *  beginning and end.
		 * 
		 *  @private BORROWED FROM FLEX SDK (3.2.03958) TO LOOSE DEPENDENCIES ON SDK 
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
		 *  Returns <code>true</code> if the specified string is
		 *  a single space, tab, carriage return, newline, or formfeed character.
		 *
		 *  @param str The String that is is being queried. 
		 *
		 *  @return <code>true</code> if the specified string is
		 *  a single space, tab, carriage return, newline, or formfeed character.
		 * 
		 *  @private BORROWED FROM FLEX SDK (3.2.03958) TO LOOSE DEPENDENCIES ON SDK 
		 */
		private static function isWhitespace(character:String):Boolean
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