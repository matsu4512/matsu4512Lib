package jp.matsu4512
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.sampler.NewObjectSample;
	
	import org.libspark.betweenas3.BetweenAS3;
	import org.libspark.betweenas3.easing.Sine;
	import org.libspark.betweenas3.tweens.ITween;
	
	public class ScalingMenu extends Sprite
	{
		public var selectedIndex:int
		public var selectedObject:Sprite;
		public var scaleTo:Number, scaleFrom:Number;
		public var alphaTo:Number, alphaFrom:Number;
		private var objects:Vector.<Sprite>;
		private var tweens:Vector.<ITween>;
		private var gap:Number;
		
		public function ScalingMenu(scaleFrom:Number, scaleTo:Number, alphaFrom:Number, alphaTo:Number, gap:Number, objects:Vector.<Sprite>=null)
		{
			super();
			this.objects = objects;
			this.scaleTo = scaleTo;
			this.scaleFrom = scaleFrom;
			this.alphaTo = alphaTo;
			this.alphaFrom = alphaFrom;
			this.gap = gap;
			if(objects != null)setMenu(objects);
		}
		
		public function setMenu(objects:Vector.<Sprite>):void{
			tweens = new Vector.<ITween>();
			this.objects = objects;
			for(var i:int = 0; i < objects.length; i++){
				objects[i].addEventListener(MouseEvent.CLICK, onClick);
				objects[i].addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				objects[i].addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				tweens[i] = null;
				objects[i].scaleX = objects[i].scaleY = scaleFrom;
				objects[i].alpha = alphaFrom;
				objects[i].buttonMode = true;
				addChild(objects[i]);
			}
			scaleUp(0);
			adjastPosition();
		}
		
		public function removeMenu():void{
			if(objects == null) return;
			for(var i:int = 0; i < objects.length; i++){
				objects[i].removeEventListener(MouseEvent.CLICK, onClick);
				objects[i].removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				objects[i].removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				removeChild(objects[i]);
			}
		}
		
		private function onClick(e:MouseEvent):void{
			var index:int = objects.indexOf(e.target);
			var from:int = this.selectedIndex;
			this.selectedIndex = index;
			this.selectedObject = e.target as Sprite;
			dispatchEvent(new ScalingMenuEvent(ScalingMenuEvent.CLICK, index, from, e.target as Sprite));
			for(var i:int = 0; i < objects.length; i++){
				if(i != selectedIndex) scaleDown(i);
			}
		}
		
		private function onMouseOver(e:MouseEvent):void{
			var index:int = objects.indexOf(e.target);
			scaleUp(index);
		}
		
		private function onMouseOut(e:MouseEvent):void{
			var index:int = objects.indexOf(e.target);
			scaleDown(index);
		}
		
		private function scaleUp(index:int):void{
			if(tweens[index] != null) tweens[index].stop();
			var obj:Sprite = objects[index];
			var t:ITween = BetweenAS3.to(obj, {scaleX:scaleTo, scaleY:scaleTo, alpha:alphaTo}, 0.2, Sine.easeOut);
			t.onUpdate = adjastPosition;
			t.play();
			tweens[index] = t;
		}
		
		private function scaleDown(index:int):void{
			if(selectedIndex == index) return;
			if(tweens[index] != null) tweens[index].stop();
			var obj:Sprite = objects[index];
			var t:ITween = BetweenAS3.to(obj, {scaleX:scaleFrom, scaleY:scaleFrom, alpha:alphaFrom}, 0.2, Sine.easeIn);
			t.onUpdate = adjastPosition;
			t.play();
			tweens[index] = t;
		}
		
		public function adjastPosition():void{
			var pos:Number = 0;
			for(var i:int = 0; i < objects.length; i++){
				objects[i].x = pos;
				pos += objects[i].width*objects[i].scaleX+gap;
			}
		}
	}
}