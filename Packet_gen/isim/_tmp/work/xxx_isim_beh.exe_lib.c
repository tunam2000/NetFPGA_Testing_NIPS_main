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

#include "xsi.h"

struct XSI_INFO xsi_info;


int isim_run(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    work_m_00000000000866782574_2073120511_init();
    work_m_00000000002822081750_3994992474_init();
    work_m_00000000001478987676_1772150813_init();
    work_m_00000000004247739818_3785133377_init();


    xsi_register_tops("work_m_00000000004247739818_3785133377");
    xsi_register_tops("work_m_00000000000866782574_2073120511");


    return xsi_run_simulation(argc, argv);

}
