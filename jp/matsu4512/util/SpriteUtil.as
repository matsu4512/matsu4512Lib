package jp.matsu4512.util
{
	import flash.display.BitmapData;
	import flash.display.IBitmapDrawable;
	import flash.display.PNGEncoderOptions;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	import jp.matsu4512.graphics.IStepSprite;
	
	public class SpriteUtil
	{
		/**
		 * png書き出しを行う
		 * @target          対象のSprite
		 * @start_frame     キャプチャを開始するフレーム
		 * @end_frame       キャプチャを終了するフレーム
		 * @captured_region キャプチャする範囲
		 * @format          書き出すファイル名のフォーマット
		 */
		static public function spriteAnimationToPng(target:IStepSprite, start_frame:int, end_frame:int, capture_region:Rectangle, format:String, save_dir:File):void
		{
			var i:int = 0;
			var frame:int = 0;
			while (frame <= end_frame) {
				if (start_frame <= frame && frame <= end_frame) {
					spriteToPng(target, capture_region, save_dir.resolvePath(StringUtil.printf(format, i)));
					i++;
				}
				target.update();
				frame++;
			}
		}
		
		static public function spriteToPng(sprite:IBitmapDrawable, capture_region:Rectangle, file:File):void
		{
			var bitmapData:BitmapData = new BitmapData(capture_region.width, capture_region.height, true, 0);
			bitmapData.draw(sprite, new Matrix(1, 0, 0, 1, -capture_region.x, -capture_region.y));
			var byteData:ByteArray = new ByteArray();
			bitmapData.encode(bitmapData.rect, new PNGEncoderOptions(), byteData);
			
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeBytes(byteData);
			fileStream.close();
		}
	}
}