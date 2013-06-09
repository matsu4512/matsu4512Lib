package jp.matsu4512
{
	import flash.display.IBitmapDrawable;
	import flash.events.IEventDispatcher;

	public interface IListElement extends IBitmapDrawable, IEventDispatcher
	{
		/**
		 * 選択時
		 */
		function select():void;
		
		/**
		 * 選択解除時
		 */
		function unselect():void;
		
		/**
		 * マウスオン時
		 */
		function mover():void;
		
		/**
		 * マウスアウト時
		 */
		function mout():void;
		
		function getWidth():Number;
		
		function getHeight():Number;
	}
}