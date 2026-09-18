pragma Ada_2022;

package body Memory_Stream is
   use type Ada.Streams.Stream_Element_Offset;

   procedure Reset_Read (Stream : in out Buffer_Stream) is
   begin
      Stream.R := 0;
   end Reset_Read;

   function Written (Stream : Buffer_Stream)
     return Ada.Streams.Stream_Element_Count is
   begin
      return Ada.Streams.Stream_Element_Count (Stream.W);
   end Written;

   procedure Write
     (Stream : in out Buffer_Stream;
      Item   : Ada.Streams.Stream_Element_Array)
   is
   begin
      for E of Item loop
         Stream.W := Stream.W + 1;
         Stream.Data (Stream.W) := E;
      end loop;
   end Write;

   procedure Read
     (Stream : in out Buffer_Stream;
      Item   : out Ada.Streams.Stream_Element_Array;
      Last   : out Ada.Streams.Stream_Element_Offset)
   is
      Idx : Ada.Streams.Stream_Element_Offset := Item'First - 1;
   begin
      while Idx < Item'Last and then Stream.R < Stream.W loop
         Stream.R := Stream.R + 1;
         Idx := Idx + 1;
         Item (Idx) := Stream.Data (Stream.R);
      end loop;
      Last := Idx;
   end Read;

end Memory_Stream;
