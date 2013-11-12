/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2007 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

/* This file is designed for use with ISim build 0x9330dbfa */

#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/mtnguyen/ISEp_Packet_gen/Packet_gen/xxx.v";
static int ng1[] = {0, 0};
static int ng2[] = {0, 0, 0, 0};
static int ng3[] = {1, 0};
static unsigned int ng4[] = {3U, 0U};
static unsigned int ng5[] = {5U, 0U};
static unsigned int ng6[] = {1U, 0U};
static unsigned int ng7[] = {1U, 0U, 0U, 0U};
static int ng8[] = {3, 0, 0, 0};
static int ng9[] = {4, 0, 0, 0};
static int ng10[] = {5, 0};
static int ng11[] = {8, 0};
static int ng12[] = {20, 0};



static void I76_0(char *t0)
{
    char t3[8];
    char *t1;
    char *t2;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    char *t17;

LAB0:    t1 = (t0 + 2988U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(76, ng0);

LAB4:    xsi_set_current_line(76, ng0);
    t2 = (t0 + 2904);
    xsi_process_wait(t2, 5000000LL);
    *((char **)t1) = &&LAB5;

LAB1:    return;
LAB5:    xsi_set_current_line(76, ng0);
    t4 = (t0 + 2432);
    t5 = (t4 + 32U);
    t6 = *((char **)t5);
    memset(t3, 0, 8);
    t7 = (t3 + 4U);
    t8 = (t6 + 4U);
    t9 = *((unsigned int *)t6);
    t10 = (~(t9));
    *((unsigned int *)t3) = t10;
    *((unsigned int *)t7) = 0;
    if (*((unsigned int *)t8) != 0)
        goto LAB7;

LAB6:    t15 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t15 & 1U);
    t16 = *((unsigned int *)t7);
    *((unsigned int *)t7) = (t16 & 1U);
    t17 = (t0 + 2432);
    xsi_vlogvar_assign_value(t17, t3, 0, 0, 1);
    goto LAB4;

LAB7:    t11 = *((unsigned int *)t3);
    t12 = *((unsigned int *)t8);
    *((unsigned int *)t3) = (t11 | t12);
    t13 = *((unsigned int *)t7);
    t14 = *((unsigned int *)t8);
    *((unsigned int *)t7) = (t13 | t14);
    goto LAB6;

LAB8:    goto LAB1;

}

static void I78_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;

LAB0:    t1 = (t0 + 3108U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(78, ng0);

LAB4:    xsi_set_current_line(80, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1052);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(81, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1144);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);
    xsi_set_current_line(82, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1236);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);
    xsi_set_current_line(83, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1328);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);
    xsi_set_current_line(84, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1420);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);
    xsi_set_current_line(85, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 1512);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 48);
    xsi_set_current_line(86, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 1604);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 48);
    xsi_set_current_line(87, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 1696);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 48);
    xsi_set_current_line(88, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 1788);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 48);
    xsi_set_current_line(89, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1880);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 16);
    xsi_set_current_line(90, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1972);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 16);
    xsi_set_current_line(91, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2064);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 16);
    xsi_set_current_line(92, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2156);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 16);
    xsi_set_current_line(93, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2248);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);
    xsi_set_current_line(94, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2340);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(95, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2432);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(96, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 2524);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(99, ng0);
    t2 = (t0 + 3024);
    xsi_process_wait(t2, 100000000LL);
    *((char **)t1) = &&LAB5;

LAB1:    return;
LAB5:    xsi_set_current_line(100, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1052);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(101, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 1144);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);
    xsi_set_current_line(102, ng0);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 1236);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);
    xsi_set_current_line(103, ng0);
    t2 = ((char*)((ng6)));
    t3 = (t0 + 1328);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);
    xsi_set_current_line(104, ng0);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 1420);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);
    xsi_set_current_line(105, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t0 + 1512);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 48);
    xsi_set_current_line(106, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t0 + 1604);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 48);
    xsi_set_current_line(107, ng0);
    t2 = ((char*)((ng8)));
    t3 = (t0 + 1696);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 48);
    xsi_set_current_line(108, ng0);
    t2 = ((char*)((ng9)));
    t3 = (t0 + 1788);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 48);
    xsi_set_current_line(109, ng0);
    t2 = ((char*)((ng6)));
    t3 = (t0 + 1880);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 16);
    xsi_set_current_line(110, ng0);
    t2 = ((char*)((ng10)));
    t3 = (t0 + 1972);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 16);
    xsi_set_current_line(111, ng0);
    t2 = ((char*)((ng6)));
    t3 = (t0 + 2064);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 16);
    xsi_set_current_line(112, ng0);
    t2 = ((char*)((ng11)));
    t3 = (t0 + 2156);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 16);
    xsi_set_current_line(113, ng0);
    t2 = ((char*)((ng12)));
    t3 = (t0 + 2248);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);
    xsi_set_current_line(114, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2340);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(115, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2524);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(117, ng0);
    t2 = (t0 + 3024);
    xsi_process_wait(t2, 100000000LL);
    *((char **)t1) = &&LAB6;
    goto LAB1;

LAB6:    xsi_set_current_line(118, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 1052);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(119, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 2340);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    goto LAB1;

}


extern void work_m_00000000004247739818_3785133377_init()
{
	static char *pe[] = {(void *)I76_0,(void *)I78_1};
	xsi_register_didat("work_m_00000000004247739818_3785133377", "isim/_tmp/work/m_00000000004247739818_3785133377.didat");
	xsi_register_executes(pe);
}
