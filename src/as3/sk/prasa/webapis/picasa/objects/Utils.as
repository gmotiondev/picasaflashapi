package sk.prasa.webapis.picasa.objects 
{
	import mx.utils.StringUtil;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class Utils
	{
		
		public static function parseString(xmllist : XMLList) : String
		{
			var tString : String = String(xmllist);
			
			if (StringUtil.trim(tString).length == 0)
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
	}
}
