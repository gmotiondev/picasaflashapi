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
import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.core.observer.IObserver;

import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;
import flash.utils.Dictionary;
/**
 * 
 */
public class UrlParams implements IObserver
{
	private var __dict : Dictionary;
	private var __suffix : String;
	private var __method : String;

	public function UrlParams(	kind : String = "photo",	
								access : String = null,
								thumbsize : String = null,
								imgmax : String = null,
								tag : String = null,
								q : String = null,
								max_results : int = 1000,
								start_index : int = 1,
								bbox : String = null,
								l : String = null)
	{
		__dict = new Dictionary();
		__suffix = "";
		__method = URLRequestMethod.GET;
		
		setParameter("v", "2"); 												// force version 2 api
		setParameter("access", access);
		setParameter("thumbsize", thumbsize);
		setParameter("imgmax", imgmax);
		setParameter("max-results", max_results);
		setParameter("start-index", start_index);
		
		setParameter("kind", kind);
		setParameter("tag", tag);
		setParameter("q", q);
		setParameter("l", l);
		
		setParameter("bbox", bbox);
	}
	
	/**
	 * @private
	 */
	public function update(o : *) : void
	{
		merge(o as UrlParams);
	}
	
	/**
	 * @private
	 */
	public function get method() : String
	{
		return __method;
	}
	
	/**
	 * @private
	 */
	public function set method(value : String) : void
	{
		__method = value;
	}
	
	/**
	 * @private
	 */
	public function get suffix() : String
	{
		return __suffix + (isRemote ? "" : ".xml");
	}
	
	/**
	 * @private
	 */
	public function set suffix(value : String) : void
	{
		__suffix = value;
	}
	
	/**
	 * Visibility parameter
	 */
	public function get access() : String
	{
		return getParameter("access");
	}
	
	/**
	 * @private
	 */
	public function set access(value : String) : void
	{
		setParameter("access", value);
	}
	
	/**
	 * Thumbnail size parameter
	 */
	public function get thumbsize() : String
	{
		return getParameter("thumbsize");
	}
	
	/**
	 * @private
	 */
	public function set thumbsize(value : String) : void
	{
		setParameter("thumbsize", value);
	}
	
	/**
	 * Image size parameter
	 */
	public function get imgmax() : String
	{
		return getParameter("imgmax");
	}
	
	/**
	 * @private
	 */
	public function set imgmax(value : String) : void
	{
		setParameter("imgmax", value);
	}
	
	/**
	 * Maximum number of results to be retrieved
	 */
	public function get max_results() : int
	{
		return getParameter("max-results");
	}
	
	/**
	 * @private
	 */
	public function set max_results(value : int) : void
	{
		setParameter("max-results", value);
	}
	
	/**
	 * 1-based index of the first result to be retrieved
	 */
	public function get start_index() : int
	{
		return getParameter("start-index");
	}
	
	/**
	 * @private
	 */
	public function set start_index(value : int) : void
	{
		setParameter("start-index", value);
	}
	
	/**
	 * Picasa Web Albums-specific query parameter for kind queries.	
	 */
	public function get kind() : String // default is photo!
	{
		return getParameter("kind");
	}	
	
	/**
	 * @private
	 */
	public function set kind(value : String) : void
	{
		setParameter("kind", value);
	}
	
	/**
	 * Tag filter parameter
	 */
	public function get tag() : String
	{
		return getParameter("tag");
	}
	
	/**
	 * @private
	 */
	public function set tag(value : String) : void
	{
		setParameter("tag", value);
	}
	
	/**
	 * Full-text query string
	 */
	public function get q() : String
	{
		return getParameter("q");
	}
	
	/**
	 * @private
	 */
	public function set q(value : String) : void
	{
		setParameter("q", value);
	}
	
	/**
	 * named search of geo data	
	 */
	public function get l() : String
	{
		return getParameter("l");
	}
	
	/**
	 * @private
	 */
	public function set l(value : String) : void
	{
		setParameter("l", value);
	}
	
	/**
	 * bounding-box search of geo coordinates
	 */
	public function get bbox() : String
	{
		return getParameter("bbox");
	}
	
	/**
	 * @private
	 */
	public function set bbox(value : String) : void
	{
		setParameter("bbox", value);
	}
	
	/**
	 * @private
	 */
	public function merge(p : UrlParams) : UrlParams
	{
		if(p != null)
		{ 
			kind = p.kind;
			
			if(p.access != null) access = p.access;
			if(p.thumbsize != null) thumbsize = p.thumbsize;
			if(p.imgmax != null) imgmax = p.imgmax;
			if(p.tag != null) tag = p.tag;
			if(p.q != null) q = p.q;
			
			max_results = p.max_results;
			start_index = p.start_index;
			
			if(p.bbox != null) bbox = p.bbox;
			if(p.l != null) l = p.l; 
		}
							
		return clone();
	}
	
	/**
	 * @private
	 */
	public function get url_request() : URLRequest
	{
		var request : URLRequest = new URLRequest();
			request.url = PicasaService.FEED_API_URL + suffix;
			request.data = isRemote ? url_variables : null;
			
		return request;
	}
	
	/**
	 * @private
	 */
	internal function get url_variables() : URLVariables
	{
		var variables : URLVariables = new URLVariables();
		
		for(var key : String in __dict)
        {
        	if(getParameter(key) != null) variables[key] = getParameter(key);
        }
        
		
		return variables;
	}
	
	/**
	 * @private
	 */
	internal function get isRemote() : Boolean
	{
		return Utils.isHttpURL(PicasaService.FEED_API_URL);
	}

	/**
	 * @private
	 */
	public function setParameter(key : String, value : *) : void
	{	
		__dict[key] = value;
	}
	
	/**
	 * @private
	 */
	public function getParameter(key : String) : *
	{	
		return __dict[key];
	}
	
	/**
	 * @private
	 */
	public function removeParameter(key : String) : void
	{	
		delete __dict[key];
	}
	
	/**
	 * @private
	 */
	internal function containsKey(key : String) : Boolean
    {
        return __dict[key] != null;
    }
    
    /**
     * @private
     */
    public function clone() : UrlParams
	{
		return new UrlParams(kind, 
							 access, 
							 thumbsize, 
							 imgmax, 
							 tag, 
							 q, 
							 max_results, 
							 start_index, 
							 bbox, 
							 l);
	}
	
	/**
	 * @inheritDoc
	 */
	public function toString() : String
	{
		var tFirst : Boolean = true;
		var tRes : String = "";
		
		for (var key : String in __dict)
		{
			if(containsKey(key))
			{
				tRes += (tFirst ? "?" : "&") + key + "=" + urlEncode(getParameter(key));
				tFirst = false;
			}
		}
			
		return tRes;
	}
}
}

/**
 * @private
 */
function urlEncode(value : String) : String
{
	const RFC3986_ENCODE : RegExp = /[^a-zA-Z0-9_.~-]/g;
	var convert : Object = new Object;
	
	convert.encode = function() : String
	{
		return String("%" + String(arguments[0]).charCodeAt().toString(16)).toUpperCase();
	};
	
	return value.replace(RFC3986_ENCODE, convert.encode);
}
