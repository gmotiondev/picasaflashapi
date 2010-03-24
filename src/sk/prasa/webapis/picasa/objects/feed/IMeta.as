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

package sk.prasa.webapis.picasa.objects.feed 
{
import sk.prasa.webapis.picasa.objects.Author;
import sk.prasa.webapis.picasa.objects.Category;
import sk.prasa.webapis.picasa.objects.Generator;
import sk.prasa.webapis.picasa.objects.Links;
/**
 * 
 */
public interface IMeta 
{
	function get id() : String;
	function set id(value : String) : void;
	
	function get title() : String;
	function set title(value : String) : void;
	
	function get links() : Links;
	function set links(value : Links) : void;
	
	function get subtitle() : String;
	function set subtitle(value : String) : void;
	
	function get rights() : String;
	function set rights(value : String) : void;
	
	function get author() : Author;
	function set author(value : Author) : void;
	
	function get updated() : Date;
	function set updated(value : Date) : void;
	
	function get category() : Category;
	function set category(value : Category) : void;
	
	function get generator() : Generator;
	function set generator(value : Generator) : void;
	
	function get icon() : String;
	function set icon(value : String) : void;
	
	function get logo() : String;
	function set logo(value : String) : void;
}
}