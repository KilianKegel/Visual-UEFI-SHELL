#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char** argv)
{
	int Status = EXIT_FAILURE;
	do {
		static struct {
			char* pszPlugInName;	// command name
			unsigned char* pBinary; // pointer to binary
		}rgPlugIn[512];				// array of plugins
		char* pszHeaderFile = NULL;
		FILE* fpHeaderFile;

		//
		// search /out:headefile.h in command line
		//
		for (int i = 1; i < argc; i++)
		{
			if (0 == _strnicmp(argv[i], "/out:", strlen("/out:")))
			{
				pszHeaderFile = &argv[i][strlen("/out:")];
				printf("HEADERFILE: %s\n", pszHeaderFile);
			}
		}

		if (NULL == pszHeaderFile)
		{
			fprintf(stderr, "failed find filename \"/out:filename\"\n");
			break;
		}

		//
		// create header file, start header file
		//
		fpHeaderFile = fopen(pszHeaderFile, "w");
		if (NULL == fpHeaderFile)
		{
			fprintf(stderr, "failed to create \"%s\"\n", pszHeaderFile);
			break;
		}
		fprintf(fpHeaderFile, "//\n//DON'T EDIT THIS FILE: this include file is automatically generated at build time\n//\n#ifndef _UEFI_SHELL_PLUGIN_H_\n#define _UEFI_SHELL_PLUGIN_H_\n");

		//////////////////////////////////////////////////////////////////////////////////
		// process all filenames given in the command line, except "/out:filename"
		//////////////////////////////////////////////////////////////////////////////////
		for (int i = 1,iPlugin = 0; i < argc; i++)
		{
			unsigned char* pc, *pclast = NULL;
			size_t fsize = (size_t) -1LL;
			FILE* fp;
			static char szTemp[2048];	// copy / working copy of current command line option for processing 

			if (0 == _strnicmp(argv[i], "/out:", strlen("/out:")))
				continue;
			//
			// read the binary given in the command line
			//
			fp = fopen(argv[i], "r+b");
			if (NULL == fp)
			{
				fprintf(stderr, "failed open \"%s\"\n", argv[i]);
				break;
			}

			fseek(fp, 0, SEEK_END);
			fgetpos(fp, (fpos_t*)&fsize);
			rewind(fp);
			printf("--> %lld\n", fsize);

			rgPlugIn[iPlugin].pBinary = malloc(fsize);
			if (1 != fread(rgPlugIn[iPlugin].pBinary, fsize, 1, fp))
			{
				fprintf(stderr, "failed reading \"%s\"\n", argv[i]);
				break;
			}
			
			//
			// isolate the pluginname, cut extension (".EFI"), remove leading path
			//
			strcpy(szTemp, argv[i]);
			pc = strtok(szTemp, "\\/");
			while (NULL != pc)
				pclast = pc,
				pc = strtok(NULL, "\\/");
			pc = strtok(pclast, ".");
			rgPlugIn[iPlugin].pszPlugInName = malloc(strlen(pc));
			strcpy(rgPlugIn[iPlugin].pszPlugInName, pc);

			printf("------------> \"%s\"\n", pc);

			//
			// append termination '\0' that is valid for non-binary files only
			//
			fprintf(fpHeaderFile, "char %s_PLUGIN[] = {\\\n", rgPlugIn[iPlugin].pszPlugInName);

			for (size_t f = 0; f < fsize; f++)
			{
				char strOffset[] = { "  /*87654321: */  " };
				if (!(f % 32))
					sprintf(strOffset, "  /*%08zX: */  ", f);
				fprintf(fpHeaderFile, "%s0x%02X,%s", (f + 0) % 32 ? "" : strOffset, rgPlugIn[iPlugin].pBinary[f], (f + 1) % 32 ? "" : "\\\n");
			}
			iPlugin++;
			//if (i % 32)
			//	fprintf(fp, "\\\n");

			fprintf(fpHeaderFile, "};\n\n");

			//rgPlugIn[iPlugin].pszPlugInName = strrchr(&)
		}

		fprintf(fpHeaderFile, "struct _PLUGIN {\n    wchar_t *wcsCmd;\n    char *pStart;\n    size_t size;\n}plugin[] = {");

		for (int i = 0; NULL != rgPlugIn[i].pszPlugInName; i++)
		{
			fprintf(fpHeaderFile,"\n    { L\"%s\", &%s_PLUGIN[0], sizeof(%s_PLUGIN) },\\", rgPlugIn[i].pszPlugInName, rgPlugIn[i].pszPlugInName, rgPlugIn[i].pszPlugInName);
		}
		fprintf(fpHeaderFile, "\n};\n\n");

		//
		// finalize header file
		//
		fprintf(fpHeaderFile, "\n#endif//_UEFI_SHELL_PLUGIN_H_");

	} while (Status = EXIT_SUCCESS);

	return Status;
}