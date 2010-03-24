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
 * Elements of a Data API search-results feed
 * 
 * The OpenSearch response elements can be used by search engines to augment 
 * existing XML formats with search-related metadata.
 */
public class OpenSearch
{
	/**
	 * Number of Search Results	
	 * 
	 * /feed/openSearch:totalResults	/rss/channel/openSearch:totalResults
	 */
	public var totalResults : uint;
	
	/**
	 * Search Result Start Index
	 * 	
	 * /feed/openSearch:startIndex		/rss/channel/openSearch:startIndex
	 */
	public var startIndex : uint;
	
	/**
	 * Number of Search Results Per Page
	 * 	
	 * /feed/openSearch:itemsPerPage	/rss/channel/openSearch:itemsPerPage
	 */
	public var itemsPerPage : uint;

	public function OpenSearch(	totalResults : uint = 0, 
								startIndex : uint = 0, 
								itemsPerPage : uint = 0)
	{	
		this.totalResults = totalResults;
		this.startIndex = startIndex;
		this.itemsPerPage = itemsPerPage;
	}
	
	/**
	 * @inheritDoc
	 */
	public function toString() : String
	{
		return  "[OpenSearch " + " " +
				"totalResults=" + totalResults + ", " +
				"startIndex=" + startIndex + ", " +
				"itemsPerPage=" + itemsPerPage + "]";
	}
}
}