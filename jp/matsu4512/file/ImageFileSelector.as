package jp.matsu4512.file
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	
	public class ImageFileSelector
	{
		private var fileReference:FileReference;
		private var loader:Loader;
		
		/**
		 * 選択された画像の読み込み処理が完了し画像データが参照可能時に実行
		 * 引数なしの関数
		 */
		public var onComplete:Function;
		
		/**
		 * 選択された画像ファイルのBitmap
		 */
		public var bitmap:Bitmap;
		
		public function ImageFileSelector()
		{
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _onImageLoadComplete);
			fileReference = new FileReference();
			fileReference.addEventListener(Event.SELECT, _onSelect);
			fileReference.addEventListener(Event.COMPLETE, _onComplete);
			fileReference.addEventListener(Event.CANCEL, _onCancel);
		}
		
		/**
		 * ファイル選択ダイアログの表示
		 * @param description ダイアログの説明文
		 * @param fileType 選択させるファイルの条件
		 * 例 browse("画像ファイルを選択してください", "*.jpg;*.jpeg;*.gif;*.png")
		 */
		public function browse(onComplete:Function):void{
			this.onComplete = onComplete;
			fileReference.browse([new FileFilter("画像ファイル", "*.jpg;*.jpeg;*.gif;*.png")]);
		}
		
		private function _onSelect(e:Event):void{
			fileReference.load();
		}
		
		private function _onComplete(e:Event):void{
			loader.loadBytes(fileReference.data);
		}
		
		private function _onCancel(e:Event):void{
			
		}
		
		private function _onImageLoadComplete(e:Event):void{
			bitmap = loader.content as Bitmap;
			onComplete.apply();
		}
	}
}