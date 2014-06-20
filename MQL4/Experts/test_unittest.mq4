//+------------------------------------------------------------------+
//|                                    test_unittest_femto_class.mq4 |
//|             Licensed under GNU GENERAL PUBLIC LICENSE Version 3. |
//|                    See a LICENSE file for detail of the license. |
//|                                    Copyright © 2014, FemtoTrader |
//|                       https://sites.google.com/site/femtotrader/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2014, FemtoTrader"
#property link      "https://sites.google.com/site/femtotrader/"
#property version   "1.00"
#property strict


#include <UnitTest.mqh>
//--- The derived class MyUnitTest
class MyUnitTest : public UnitTest        // After a colon we define the base class
  {                                       // from which inheritance is made
public:
   void runAllTests()
     {
      initUnitTest();

      initTestCase(); test_01_bool_assertTrue_succeed(); endTestCase();
      initTestCase(); test_02_bool_assertFalse_succeed(); endTestCase();
      initTestCase(); test_03_integers_int_assertEquals_succeed();  endTestCase();
      initTestCase(); test_04_integers_long_assertEquals_succeed();  endTestCase();
      initTestCase(); test_05_float_assertEquals_succeed();  endTestCase();
      initTestCase(); testGetMA_shoudReturnSMA(); endTestCase();
      initTestCase(); testGetMAArray_shoudReturnCoupleOfSMA(); endTestCase();

      endUnitTest();
     };

private:
   void initTestCase()
     {
      Print(StringConcatenate(UT_SPACE_TESTCASE,"initTestCase before every test"));
     }

   void test_01_bool_assertTrue_succeed()
     {
      unittest.addTest(__FUNCTION__);
      unittest.assertTrue("assertTrue should succeed", true);
      //unittest.assertTrue("assertTrue should fail", false); // comment this line to pass unit test
      unittest.assertTrue("assertTrue should succeed",true);
     }

   void test_02_bool_assertFalse_succeed()
     {
      unittest.addTest(__FUNCTION__);
      unittest.assertFalse("assertFalse should succeed", false);
      //unittest.assertFalse("assertFalse should fail", true); // comment this line to pass unit test
     }

   void test_03_integers_int_assertEquals_succeed()
     {
      unittest.addTest(__FUNCTION__);
      int actual,expected;
      expected=42;
      actual=42;
      unittest.assertEquals("assertEquals with 2 integers should succeed",expected,actual);
      actual=43;
      //unittest.assertEquals("assertEquals with 2 integers should fail", expected, actual); // comment this line to pass unit test
     }

   void test_04_integers_long_assertEquals_succeed()
     {
      unittest.addTest(__FUNCTION__);
      long actual,expected;
      expected=42;
      actual=42;
      unittest.assertEquals("assertEquals with 2 integers should succeed",expected,actual);
      //unittest.assertEquals("assertEquals with 2 integers should succeed",expected,actual);
      actual=43;
      //unittest.assertEquals("assertEquals with 2 integers should fail", expected, actual); // comment this line to pass unit test
     }

   void test_05_float_assertEquals_succeed()
     {
      unittest.addTest(__FUNCTION__);
      float actual,expected;
      expected=42.0;
      actual=42.0;
      unittest.assertEquals("assertEquals with 2 floats should succeed",expected,actual);
      actual=43.0;
      //unittest.assertEquals("assertEquals with 2 floats should fail",expected,actual); // comment this line to pass unit test
     }

   void test_06_string_assertEquals_succeed()
     {
      unittest.addTest(__FUNCTION__);
      string actual,expected;
      expected="abc";
      actual="abc";
      unittest.assertEquals("assertEquals with 2 integers should succeed",expected,actual);
      actual="abA";
      //unittest.assertEquals("assertEquals with 2 integers should fail",expected,actual); // comment this line to pass unit test
     }

   void testGetMA_shoudReturnSMA()
     {
      unittest.addTest(__FUNCTION__);

      const double actual=getMA(3);
      const double expected=iMA(NULL,0,paramMAPeriod,0,MODE_SMA,PRICE_CLOSE,3);

      unittest.assertEquals("MA must be SMA and 3 bars shifted",expected,actual);
      //unittest.assertTrue("assertTrue should fail", false); // comment this line to pass unit test
     }

   void testGetMAArray_shoudReturnCoupleOfSMA()
     {
      unittest.addTest(__FUNCTION__);

      const int shifts[]={4,5};
      double actual[2];
      getMAArray(shifts,actual);

      double expected[2];
      expected[0] = iMA(NULL, 0, paramMAPeriod, 0, MODE_SMA, PRICE_CLOSE, 4);
      expected[1] = iMA(NULL, 0, paramMAPeriod, 0, MODE_SMA, PRICE_CLOSE, 5);

      unittest.assertEquals("MA array must contains a couple of SMA",expected,actual);
      //unittest.assertTrue("assertTrue should fail", false); // comment this line to pass unit test
     }
  };

MyUnitTest *unittest;

input int paramMAPeriod=13;

// This is must be false if release version
input bool g_unit_testing=true; //Enable unit testing
input bool g_unit_testing_OnInit=true; //Run unit testing when OnInit events occurs
input bool g_unit_testing_OnLoop=false; //Run unit testing when loop occurs
input bool g_unit_testing_OnTick=false; //Run unit testing when OnTick events occurs
input bool g_alert_when_failed=true; //Alert message when assert failed
input int g_loop_ms=500; //Loop delay (ms)
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
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

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   if(g_unit_testing)
     {
      unittest.printSummary();
     }

   delete unittest;
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   if(g_unit_testing && g_unit_testing_OnTick)
     {
      unittest.runAllTests();
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getMA(int shift)
  {
   return (iMA(NULL, 0, paramMAPeriod, 0, MODE_SMA, PRICE_CLOSE, shift));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void getMAArray(const int &shifts[],double &mas[])
  {
   for(int i=0; i<ArraySize(shifts); i++)
     {
      mas[i]=getMA(shifts[i]);
     }
  }

//+------------------------------------------------------------------+
