//+------------------------------------------------------------------+
//|                                                     UnitTest.mqh |
//|             Licensed under GNU GENERAL PUBLIC LICENSE Version 3. |
//|                    See a LICENSE file for detail of the license. |
//|                                    Copyright © 2014, FemtoTrader |
//|                       https://sites.google.com/site/femtotrader/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2014, FemtoTrader"
#property link      "https://sites.google.com/site/femtotrader/"
#property version   "1.00"
#property strict

#define UT_SPACE_TESTCASE "  "
#define UT_SPACE_ASSERT "    "
#define UT_SEP " - "
#define UT_COMP_EXP_ACT "%s: expected is <%s> but <%s>"
#define UT_COMP_ARR_EXP_ACT "%s: expected array[%d] is <%s> but <%s>"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
/*
Inspired from https://github.com/micclly/mt4-unittest
*/

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class UnitTest
  {
public:
                     UnitTest();
                    ~UnitTest();

   void              addTest(string test_name);
   void              printSummary();

   void              initUnitTest(void);
   void              endUnitTest(void);

   void              initTestCase(void);
   void              endTestCase(void);

   void              assertTrue(string message,bool actual);
   void              assertFalse(string message,bool actual);

   void              assertEquals(string message,bool expected,bool actual);
   void              assertEquals(string message,char expected,char actual);
   void              assertEquals(string message,uchar expected,uchar actual);
   void              assertEquals(string message,short expected,short actual);
   void              assertEquals(string message,ushort expected,ushort actual);
   void              assertEquals(string message,int expected,int actual);
   void              assertEquals(string message,uint expected,uint actual);
   void              assertEquals(string message,long expected,long actual);
   void              assertEquals(string message,ulong expected,ulong actual);
   void              assertEquals(string message,datetime expected,datetime actual);
   void              assertEquals(string message,color expected,color actual);
   void              assertEquals(string message,float expected,float actual);
   void              assertEquals(string message,double expected,double actual);
   void              assertEquals(string message,string expected,string actual);

   void              assertEquals(string message,const bool &expected[],const bool &actual[]);
   void              assertEquals(string message,const char &expected[],const char &actual[]);
   void              assertEquals(string message,const uchar &expected[],const uchar &actual[]);
   void              assertEquals(string message,const short &expected[],const short &actual[]);
   void              assertEquals(string message,const ushort &expected[],const ushort &actual[]);
   void              assertEquals(string message,const int &expected[],const int &actual[]);
   void              assertEquals(string message,const uint &expected[],const uint &actual[]);
   void              assertEquals(string message,const long &expected[],const long &actual[]);
   void              assertEquals(string message,const ulong &expected[],const ulong &actual[]);
   void              assertEquals(string message,const datetime &expected[],const datetime &actual[]);
   void              assertEquals(string message,const color &expected[],const color &actual[]);
   void              assertEquals(string message,const float &expected[],const float &actual[]);
   void              assertEquals(string message,const double &expected[],const double &actual[]);
   void              assertEquals(string message,const string &expected[],const string &actual[]);

protected:
   string            m_current_test_name;

private:
   void              __assertTrue(string message,bool expected,bool actual);

   int               m_test_count;
   int               m_test_count_fail;

   int               m_current_assert_count;
   int               m_current_assert_count_fail;

   int               m_total_assert_count;
   int               m_total_assert_count_fail;

   void              setAssertSuccess(string message);
   void              setAssertFailure(string message);

   void              addAssert();

   string            summary(int count,int count_fail);
   void              printUnitTestSummary();
   void              printTestCaseSummary(void);

   bool              assertArraySize(string message,const int expectedSize,const int actualSize);

  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
UnitTest::UnitTest()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
UnitTest::~UnitTest(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::initUnitTest(void)
  {
   Print("UnitTest - start");
   Print("================");

   m_test_count=0;
   m_test_count_fail=0;

   m_current_assert_count=0;
   m_current_assert_count_fail=0;

   m_total_assert_count=0;
   m_total_assert_count_fail=0;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::addTest(string test_name)
  {
   Print(StringConcatenate(UT_SPACE_TESTCASE,m_current_test_name,UT_SEP,"Running new unit test"));

   m_current_test_name=test_name;

   m_current_assert_count=0;
   m_current_assert_count_fail=0;

   m_test_count+=1;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::initTestCase(void)
  {
//Print(StringConcatenate(UT_SPACE_TESTCASE,"initTestCase"));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::endTestCase(void)
  {
   printTestCaseSummary();

   if(m_current_assert_count_fail!=0)
     {
      m_test_count_fail+=1;
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::printTestCaseSummary(void)
  {
   Print(StringConcatenate(UT_SPACE_TESTCASE,m_current_test_name,UT_SEP,"endTestCase"));

   string s=StringConcatenate(
                              UT_SPACE_TESTCASE,m_current_test_name,UT_SEP,
                              get_OK_Fail(m_current_assert_count_fail==0),UT_SEP,
                              summary(m_current_assert_count,m_current_assert_count_fail));

   Print(s);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

string UnitTest::summary(int count,int count_fail)
  {
   int count_success=count-count_fail;
   double count_success_percent;
   double count_failure_percent;
   if(count!=0)
     {
      count_success_percent= 100.0 * count_success/count;
      count_failure_percent= 100.0 * count_fail/count;
        } else {
      count_success_percent= 100.0;
      count_failure_percent= 0.0;
     }

   string s=StringFormat("Total: %d, Success: %d (%.2f%%), Failure: %d (%.2f%%)",
                         count,count_success,count_success_percent,
                         count_fail,count_failure_percent);
   return(s);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::printUnitTestSummary(void)
  {
   Print("UnitTest summary");
   Print("================");

   string s_tests,s_asserts;

   s_asserts=StringConcatenate("asserts: ",summary(m_total_assert_count,m_total_assert_count_fail));

   Print(s_asserts);

   s_tests=StringConcatenate(get_OK_Fail(m_test_count_fail==0),
                             UT_SEP,summary(m_test_count,m_test_count_fail));
   Print(s_tests);

   Comment(s_tests+"\n"+s_asserts);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::printSummary(void)
  {
   printUnitTestSummary();
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string get_OK_Fail(bool ok)
  {
   if(ok)
     {
      return("    OK    ");
        } else {
      return("***FAIL***");
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::addAssert()
  {
   m_current_assert_count+=1;
   m_total_assert_count+=1;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::endUnitTest(void)
  {
   printUnitTestSummary();
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::setAssertFailure(string message)
  {
   m_current_assert_count_fail+=1;
   m_total_assert_count_fail+=1;
   Print(StringConcatenate(UT_SPACE_ASSERT,m_current_test_name,UT_SEP,get_OK_Fail(false),UT_SEP,message));
   if(g_alert_when_failed)
     {
      Alert(StringConcatenate(get_OK_Fail(false),UT_SEP,m_current_test_name,UT_SEP,message));
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::setAssertSuccess(string message)
  {
   Print(StringConcatenate(UT_SPACE_ASSERT,m_current_test_name,UT_SEP,get_OK_Fail(true),UT_SEP,message));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::__assertTrue(string message,bool expected,bool actual)
  {
   addAssert();

   if(actual==expected)
     {
      setAssertSuccess(message);
     }
   else
     {
      message=StringFormat(UT_COMP_EXP_ACT,message,BooleanToString(expected),BooleanToString(actual));
      setAssertFailure(message);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::assertTrue(string message,bool actual)
  {
   __assertTrue(message,true,actual);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::assertFalse(string message,bool actual)
  {
   __assertTrue(message,false,actual);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::assertEquals(string message,char expected,char actual)
  {
   addAssert();

   if(actual==expected)
     {
      setAssertSuccess(message);
     }
   else
     {
      message=StringFormat(UT_COMP_EXP_ACT,message,CharToString(expected),CharToString(actual));
      setAssertFailure(message);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::assertEquals(string message,uchar expected,uchar actual)
  {
   addAssert();

   if(actual==expected)
     {
      setAssertSuccess(message);
     }
   else
     {
      message=StringFormat(UT_COMP_EXP_ACT,message,CharToString(expected),CharToString(actual));
      setAssertFailure(message);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::assertEquals(string message,short expected,short actual)
  {
   addAssert();

   if(actual==expected)
     {
      setAssertSuccess(message);
     }
   else
     {
      message=StringFormat(UT_COMP_EXP_ACT,message,IntegerToString(expected),IntegerToString(actual));
      setAssertFailure(message);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::assertEquals(string message,ushort expected,ushort actual)
  {
   addAssert();

   if(actual==expected)
     {
      setAssertSuccess(message);
     }
   else
     {
      message=StringFormat(UT_COMP_EXP_ACT,message,IntegerToString(expected),IntegerToString(actual));
      setAssertFailure(message);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::assertEquals(string message,int expected,int actual)
  {
   addAssert();

   if(actual==expected)
     {
      setAssertSuccess(message);
     }
   else
     {
      message=StringFormat(UT_COMP_EXP_ACT,message,IntegerToString(expected),IntegerToString(actual));
      setAssertFailure(message);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::assertEquals(string message,uint expected,uint actual)
  {
   addAssert();

   if(actual==expected)
     {
      setAssertSuccess(message);
     }
   else
     {
      message=StringFormat(UT_COMP_EXP_ACT,message,IntegerToString(expected),IntegerToString(actual));
      setAssertFailure(message);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::assertEquals(string message,long expected,long actual)
  {
   addAssert();

   if(actual==expected)
     {
      setAssertSuccess(message);
     }
   else
     {
      message=StringFormat(UT_COMP_EXP_ACT,message,IntegerToString(expected),IntegerToString(actual));
      setAssertFailure(message);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::assertEquals(string message,ulong expected,ulong actual)
  {
   addAssert();

   if(actual==expected)
     {
      setAssertSuccess(message);
     }
   else
     {
      message=StringFormat(UT_COMP_EXP_ACT,message,IntegerToString(expected),IntegerToString(actual));
      setAssertFailure(message);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::assertEquals(string message,datetime expected,datetime actual)
  {
   addAssert();

   if(actual==expected)
     {
      setAssertSuccess(message);
     }
   else
     {
      message=StringFormat(UT_COMP_EXP_ACT,message,TimeToString(expected),TimeToString(actual));
      setAssertFailure(message);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::assertEquals(string message,color expected,color actual)
  {
   addAssert();

   if(actual==expected)
     {
      setAssertSuccess(message);
     }
   else
     {
      message=StringFormat(UT_COMP_EXP_ACT,message,ColorToString(expected),ColorToString(actual));
      setAssertFailure(message);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::assertEquals(string message,float expected,float actual)
  {
   addAssert();

   if(actual==expected)
     {
      setAssertSuccess(message);
     }
   else
     {
      message=StringFormat(UT_COMP_EXP_ACT,message,DoubleToString(expected),DoubleToString(actual));
      setAssertFailure(message);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::assertEquals(string message,double expected,double actual)
  {
   addAssert();

   if(actual==expected)
     {
      setAssertSuccess(message);
     }
   else
     {
      message=StringFormat(UT_COMP_EXP_ACT,message,DoubleToString(expected),DoubleToString(actual));
      setAssertFailure(message);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::assertEquals(string message,string expected,string actual)
  {
   addAssert();

   if(actual==expected)
     {
      setAssertSuccess(message);
     }
   else
     {
      message=StringFormat(UT_COMP_EXP_ACT,message,expected,actual);
      setAssertFailure(message);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool UnitTest::assertArraySize(string message,const int expectedSize,const int actualSize)
  {
   addAssert();
   if(actualSize==expectedSize)
     {
      return true;
     }
   else
     {
      //const string m = message + ": expected array size is <" + IntegerToString(expectedSize) +
      //    "> but <" + IntegerToString(actualSize) + ">";
      message=StringFormat("%s: expected array size is <%s> but <%s>",message,
                           IntegerToString(expectedSize),IntegerToString(actualSize));
      setAssertFailure(message);
      return false;
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::assertEquals(string message,const bool &expected[],const bool &actual[])
  {
   addAssert();
   const int expectedSize=ArraySize(expected);
   const int actualSize=ArraySize(actual);

   if(!assertArraySize(message,expectedSize,actualSize))
     {
      return;
     }

   for(int i=0; i<actualSize; i++)
     {
      if(expected[i]!=actual[i])
        {
         message=StringFormat(UT_COMP_ARR_EXP_ACT,message,
                              i,BooleanToString(expected[i]),BooleanToString(actual[i]));
         setAssertFailure(message);
         return;
        }
     }

   setAssertSuccess(message);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::assertEquals(string message,const char &expected[],const char &actual[])
  {
   addAssert();
   const int expectedSize=ArraySize(expected);
   const int actualSize=ArraySize(actual);

   if(!assertArraySize(message,expectedSize,actualSize))
     {
      return;
     }

   for(int i=0; i<actualSize; i++)
     {
      if(expected[i]!=actual[i])
        {
         message=StringFormat(UT_COMP_ARR_EXP_ACT,message,
                              i,CharToString(expected[i]),CharToString(actual[i]));
         setAssertFailure(message);
         return;
        }
     }

   setAssertSuccess(message);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::assertEquals(string message,const uchar &expected[],const uchar &actual[])
  {
   addAssert();
   const int expectedSize=ArraySize(expected);
   const int actualSize=ArraySize(actual);

   if(!assertArraySize(message,expectedSize,actualSize))
     {
      return;
     }

   for(int i=0; i<actualSize; i++)
     {
      if(expected[i]!=actual[i])
        {
         message=StringFormat(UT_COMP_ARR_EXP_ACT,message,
                              i,CharToString(expected[i]),CharToString(actual[i]));
         setAssertFailure(message);
         return;
        }
     }

   setAssertSuccess(message);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::assertEquals(string message,const short &expected[],const short &actual[])
  {
   addAssert();
   const int expectedSize=ArraySize(expected);
   const int actualSize=ArraySize(actual);

   if(!assertArraySize(message,expectedSize,actualSize))
     {
      return;
     }

   for(int i=0; i<actualSize; i++)
     {
      if(expected[i]!=actual[i])
        {
         message=StringFormat(UT_COMP_ARR_EXP_ACT,message,
                              i,IntegerToString(expected[i]),IntegerToString(actual[i]));
         setAssertFailure(message);
         return;
        }
     }

   setAssertSuccess(message);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::assertEquals(string message,const ushort &expected[],const ushort &actual[])
  {
   addAssert();
   const int expectedSize=ArraySize(expected);
   const int actualSize=ArraySize(actual);

   if(!assertArraySize(message,expectedSize,actualSize))
     {
      return;
     }

   for(int i=0; i<actualSize; i++)
     {
      if(expected[i]!=actual[i])
        {
         message=StringFormat(UT_COMP_ARR_EXP_ACT,message,
                              i,IntegerToString(expected[i]),IntegerToString(actual[i]));
         setAssertFailure(message);
         return;
        }
     }

   setAssertSuccess(message);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::assertEquals(string message,const int &expected[],const int &actual[])
  {
   addAssert();
   const int expectedSize=ArraySize(expected);
   const int actualSize=ArraySize(actual);

   if(!assertArraySize(message,expectedSize,actualSize))
     {
      return;
     }

   for(int i=0; i<actualSize; i++)
     {
      if(expected[i]!=actual[i])
        {
         message=StringFormat(UT_COMP_ARR_EXP_ACT,message,
                              i,IntegerToString(expected[i]),IntegerToString(actual[i]));
         setAssertFailure(message);
         return;
        }
     }

   setAssertSuccess(message);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::assertEquals(string message,const uint &expected[],const uint &actual[])
  {
   addAssert();
   const int expectedSize=ArraySize(expected);
   const int actualSize=ArraySize(actual);

   if(!assertArraySize(message,expectedSize,actualSize))
     {
      return;
     }

   for(int i=0; i<actualSize; i++)
     {
      if(expected[i]!=actual[i])
        {
         message=StringFormat(UT_COMP_ARR_EXP_ACT,message,
                              i,IntegerToString(expected[i]),IntegerToString(actual[i]));
         setAssertFailure(message);
         return;
        }
     }

   setAssertSuccess(message);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::assertEquals(string message,const long &expected[],const long &actual[])
  {
   addAssert();
   const int expectedSize=ArraySize(expected);
   const int actualSize=ArraySize(actual);

   if(!assertArraySize(message,expectedSize,actualSize))
     {
      return;
     }

   for(int i=0; i<actualSize; i++)
     {
      if(expected[i]!=actual[i])
        {
         message=StringFormat(UT_COMP_ARR_EXP_ACT,message,
                              i,IntegerToString(expected[i]),IntegerToString(actual[i]));
         setAssertFailure(message);
         return;
        }
     }

   setAssertSuccess(message);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::assertEquals(string message,const ulong &expected[],const ulong &actual[])
  {
   addAssert();
   const int expectedSize=ArraySize(expected);
   const int actualSize=ArraySize(actual);

   if(!assertArraySize(message,expectedSize,actualSize))
     {
      return;
     }

   for(int i=0; i<actualSize; i++)
     {
      if(expected[i]!=actual[i])
        {
         message=StringFormat(UT_COMP_ARR_EXP_ACT,message,
                              i,IntegerToString(expected[i]),IntegerToString(actual[i]));
         setAssertFailure(message);
         return;
        }
     }

   setAssertSuccess(message);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::assertEquals(string message,const datetime &expected[],const datetime &actual[])
  {
   addAssert();
   const int expectedSize=ArraySize(expected);
   const int actualSize=ArraySize(actual);

   if(!assertArraySize(message,expectedSize,actualSize))
     {
      return;
     }

   for(int i=0; i<actualSize; i++)
     {
      if(expected[i]!=actual[i])
        {
         message=StringFormat(UT_COMP_ARR_EXP_ACT,message,
                              i,TimeToString(expected[i]),TimeToString(actual[i]));
         setAssertFailure(message);
         return;
        }
     }

   setAssertSuccess(message);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::assertEquals(string message,const color &expected[],const color &actual[])
  {
   addAssert();
   const int expectedSize=ArraySize(expected);
   const int actualSize=ArraySize(actual);

   if(!assertArraySize(message,expectedSize,actualSize))
     {
      return;
     }

   for(int i=0; i<actualSize; i++)
     {
      if(expected[i]!=actual[i])
        {
         message=StringFormat(UT_COMP_ARR_EXP_ACT,message,
                              i,ColorToString(expected[i]),ColorToString(actual[i]));
         setAssertFailure(message);
         return;
        }
     }

   setAssertSuccess(message);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::assertEquals(string message,const float &expected[],const float &actual[])
  {
   addAssert();
   const int expectedSize=ArraySize(expected);
   const int actualSize=ArraySize(actual);

   if(!assertArraySize(message,expectedSize,actualSize))
     {
      return;
     }

   for(int i=0; i<actualSize; i++)
     {
      if(expected[i]!=actual[i])
        {
         message=StringFormat(UT_COMP_ARR_EXP_ACT,message,
                              i,DoubleToString(expected[i]),DoubleToString(actual[i]));
         setAssertFailure(message);
         return;
        }
     }

   setAssertSuccess(message);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UnitTest::assertEquals(string message,const double &expected[],const double &actual[])
  {
   addAssert();
   const int expectedSize=ArraySize(expected);
   const int actualSize=ArraySize(actual);

   if(!assertArraySize(message,expectedSize,actualSize))
     {
      return;
     }

   for(int i=0; i<actualSize; i++)
     {
      if(expected[i]!=actual[i])
        {
         message=StringFormat(UT_COMP_ARR_EXP_ACT,message,
                              i,DoubleToString(expected[i]),DoubleToString(actual[i]));
         setAssertFailure(message);
         return;
        }
     }

   setAssertSuccess(message);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string BooleanToString(bool b)
  {
   if(b)
     {
      return("true");
        }else {
      return("false");
     }
  }


void UT_OnInit() {
   if(g_unit_testing)
     {
      unittest=new MyUnitTest();
     }

   if(g_unit_testing_OnInit)
     {
      unittest.runAllTests();
     }

   if(g_unit_testing_OnLoop)
     {
      datetime prev_time=TimeLocal();
      while(true)
        {
         if((TimeLocal()-prev_time)>=1) //Do stuff once per second
           {
            prev_time=TimeLocal();

            unittest.runAllTests();

           }
         Sleep(g_loop_ms);
        }
     }
}

void UT_OnDeinit() {
   if(g_unit_testing)
     {
      unittest.printSummary();
     }

   delete unittest;
}

void UT_OnTick() {
   if(g_unit_testing && g_unit_testing_OnTick)
     {
      unittest.runAllTests();
     }
}

//+------------------------------------------------------------------+
