pragma Ada_2022;

with Ada.Streams;

package Memory_Stream is

   type Buffer_Stream (Capacity : Ada.Streams.Stream_Element_Count) is
     new Ada.Streams.Root_Stream_Type with private;

   overriding procedure Read
     (Stream : in out Buffer_Stream;
      Item   : out Ada.Streams.Stream_Element_Array;
      Last   : out Ada.Streams.Stream_Element_Offset);

   overriding procedure Write
     (Stream : in out Buffer_Stream;
      Item   : Ada.Streams.Stream_Element_Array);

   procedure Reset_Read (Stream : in out Buffer_Stream);
   function Written (Stream : Buffer_Stream)
     return Ada.Streams.Stream_Element_Count;

private

   type Buffer_Stream (Capacity : Ada.Streams.Stream_Element_Count) is
     new Ada.Streams.Root_Stream_Type with record
      Data : Ada.Streams.Stream_Element_Array (1 .. Capacity) := [others => 0];
      W    : Ada.Streams.Stream_Element_Offset := 0;
      R    : Ada.Streams.Stream_Element_Offset := 0;
   end record;

end Memory_Stream;
