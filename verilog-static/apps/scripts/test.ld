/*======================================================================*/
/* Proxy kernel linker script                                           */
/*======================================================================*/
/* This is the linker script used when building the proxy kernel. */

/*----------------------------------------------------------------------*/
/* Setup                                                                */
/*----------------------------------------------------------------------*/

/* The OUTPUT_ARCH command specifies the machine architecture where the
   argument is one of the names used in the BFD library. More
   specifically one of the entires in bfd/cpu-mips.c */

OUTPUT_ARCH( "mips:maven" )

/* The ENTRY command specifies the entry point (ie. first instruction
   to execute). The symbol _test should be defined in each test. */

ENTRY( _test )

/*----------------------------------------------------------------------*/
/* Sections                                                             */
/*----------------------------------------------------------------------*/

SECTIONS
{

  /* xcpthandler: exception handle */
  . = 0x00000004;
  .xcpthandler :
  {
    *(.xcpthandler)
  }

  /* text: test code section */
  . = 0x00080000;
  .text : 
  {
    *(.text)
  }

  /* data: Initialized data segment */
  .data : 
  {
    *(.data)
  }

  /* End of uninitalized data segement */
  _end = .;
}

