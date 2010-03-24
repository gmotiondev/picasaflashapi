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
 * Picasa Web Albums represent Exif data encoded in a photo.
 */
public class Exif 
{
	/**
	 * The distance to the subject.
	 */
	public var distance : Number; 		// exif:distance
	
	/**
	 * The exposure time used.
	 */
	public var exposure : Number; 		// exif:exposure
	
	/**
	 * Boolean value indicating whether the flash was used.
	 */
	public var flash : Boolean;			// exif:flash
	
	/**
	 * The focal length used.
	 */
	public var focallength : Number; 	// exif:focallength
	
	/**
	 * The fstop value used.
	 */
	public var fstop : Number;			// exif:fstop
	
	/**
	 * The unique image ID for the photo.
	 */
	public var imageUniqueID : String;	// exif:imageUniqueID
	
	/**
	 * The iso equivalent value used.
	 */
	public var iso : Number;			// exif:iso
	
	/**
	 * The make of the camera used.
	 */
	public var make : String;			// exif:make
	
	/**
	 * The model of the camera used.
	 */
	public var model : String;			// exif:model
	
	/**
	 * he date/time the photo was taken, 
	 * represented as the number of milliseconds since January 1st, 1970.
	 * 
	 * The value of this element should always be identical 
	 * to the value of the <gphoto:timestamp>.
	 */
	public var time : Number;			// exif:time
	
	/**
	 * @inheritDoc
	 */
	public function toString() : String
	{
		return  "[Exif " +
				" distance=" + distance +
				", exposure=" + exposure +
				", flash=" + flash +
				", focallength=" + focallength +
				", fstop=" + fstop +
				", imageUniqueID=" + imageUniqueID +
				", iso=" + iso +
				", make=" + make +
				", model=" + model +
				", time=" + time +
				"]";
	}
}
}