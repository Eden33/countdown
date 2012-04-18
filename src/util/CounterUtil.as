package util
{
	import flash.events.EventDispatcher;

	[Event(name="finished", type="util.CounterFinishedEvent")]
	public class CounterUtil extends EventDispatcher
	{
		public static const FINISHED:String = "finished";
		
		private var endDate:Date = null;
		private var _millisLeft:Number = 0;
		
		private var _days:int = 0;
		private var _hours:int = 0;
		private var _minutes:int = 0;
		private var _seconds:int = 0;
		
		public function CounterUtil(endDate:Date) 
		{
			this.endDate = endDate;
		}
		
		//TODO: find out how to make private
		public function set seconds(value:int):void
		{
			if(value <= 0 && _minutes <= 0 && _hours <= 0 && days <= 0)
			{
				dispatchEvent(new CounterFinishedEvent(CounterUtil.FINISHED));
			}
			_seconds = value;
		}

		public function get seconds():int
		{
			return _seconds;
		}

		public function get minutes():int
		{
			return _minutes;
		}

		public function get hours():int
		{
			return _hours;
		}

		public function get days():int
		{
			return _days;
		}

		public function doTick() : void
		{
			var now:Date = new Date();
			millisLeft = endDate.time - now.time;
			_days = (_millisLeft / (1000 * 60 * 60 * 24)) ;
			if(_days > 0) 
			{
				_millisLeft = _millisLeft % (1000 * 60 * 60 * 24);	
			}
			_hours = (_millisLeft / (1000 * 60 * 60)) ;
			if(_hours > 0) 
			{
				_millisLeft = _millisLeft % (1000 * 60 * 60);	
			}
			_minutes = (_millisLeft / (1000 * 60)) ;
			if(_minutes > 0) 
			{
				_millisLeft = _millisLeft % (1000 * 60);	
			}
			seconds = (_millisLeft / 1000) ;
			if(_seconds > 0) 
			{
				_millisLeft = (_millisLeft % 1000);	
			}
		
		}

		protected function set millisLeft(value:Number):void
		{
			if(value >= 0) 
			{
				_millisLeft = value;	
			} 
			else 
			{
				_millisLeft = 0;
			}
		}
	}
}