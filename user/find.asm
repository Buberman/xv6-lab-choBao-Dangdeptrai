
user/_find:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <match>:
#define MAX_PATH 512

char *strcat(char *dest, const char *src);

int match(char *s, char *p) {
    while (*s && *p) {
   0:	00054703          	lbu	a4,0(a0)
        if (*p == '*') {
   4:	02a00693          	li	a3,42
            while (*s) {
                if (match(s++, p + 1))
                    return 1;
            }
            return 0;
        } else if (*p == '.' || *s == *p) {
   8:	02e00613          	li	a2,46
    while (*s && *p) {
   c:	ef29                	bnez	a4,66 <match+0x66>
            p++;
        } else {
            return 0;
        }
    }
    return *s == '\0' && *p == '\0';
   e:	0005c703          	lbu	a4,0(a1)
  12:	00173713          	seqz	a4,a4
}
  16:	853a                	mv	a0,a4
  18:	8082                	ret
            if (*(p + 1) == '\0') 
  1a:	0015c783          	lbu	a5,1(a1)
                return 1;
  1e:	4705                	li	a4,1
            if (*(p + 1) == '\0') 
  20:	dbfd                	beqz	a5,16 <match+0x16>
int match(char *s, char *p) {
  22:	1101                	addi	sp,sp,-32
  24:	ec06                	sd	ra,24(sp)
  26:	e822                	sd	s0,16(sp)
  28:	e426                	sd	s1,8(sp)
  2a:	e04a                	sd	s2,0(sp)
  2c:	1000                	addi	s0,sp,32
                if (match(s++, p + 1))
  2e:	00158493          	addi	s1,a1,1
            while (*s) {
  32:	00054783          	lbu	a5,0(a0)
  36:	cb99                	beqz	a5,4c <match+0x4c>
                if (match(s++, p + 1))
  38:	00150913          	addi	s2,a0,1
  3c:	85a6                	mv	a1,s1
  3e:	00000097          	auipc	ra,0x0
  42:	fc2080e7          	jalr	-62(ra) # 0 <match>
  46:	e91d                	bnez	a0,7c <match+0x7c>
  48:	854a                	mv	a0,s2
  4a:	b7e5                	j	32 <match+0x32>
            return 0;
  4c:	4701                	li	a4,0
}
  4e:	853a                	mv	a0,a4
  50:	60e2                	ld	ra,24(sp)
  52:	6442                	ld	s0,16(sp)
  54:	64a2                	ld	s1,8(sp)
  56:	6902                	ld	s2,0(sp)
  58:	6105                	addi	sp,sp,32
  5a:	8082                	ret
            s++;
  5c:	0505                	addi	a0,a0,1
            p++;
  5e:	0585                	addi	a1,a1,1
    while (*s && *p) {
  60:	00054703          	lbu	a4,0(a0)
  64:	d74d                	beqz	a4,e <match+0xe>
  66:	0005c783          	lbu	a5,0(a1)
  6a:	cb99                	beqz	a5,80 <match+0x80>
        if (*p == '*') {
  6c:	fad787e3          	beq	a5,a3,1a <match+0x1a>
        } else if (*p == '.' || *s == *p) {
  70:	fec786e3          	beq	a5,a2,5c <match+0x5c>
  74:	fee784e3          	beq	a5,a4,5c <match+0x5c>
            return 0;
  78:	4701                	li	a4,0
  7a:	bf71                	j	16 <match+0x16>
                    return 1;
  7c:	4705                	li	a4,1
  7e:	bfc1                	j	4e <match+0x4e>
    return *s == '\0' && *p == '\0';
  80:	00173713          	seqz	a4,a4
  84:	bf49                	j	16 <match+0x16>

0000000000000086 <catdir>:

void catdir(char *prefix, char *name, char *buf) {
  86:	7139                	addi	sp,sp,-64
  88:	fc06                	sd	ra,56(sp)
  8a:	f822                	sd	s0,48(sp)
  8c:	f426                	sd	s1,40(sp)
  8e:	f04a                	sd	s2,32(sp)
  90:	ec4e                	sd	s3,24(sp)
  92:	e852                	sd	s4,16(sp)
  94:	e456                	sd	s5,8(sp)
  96:	0080                	addi	s0,sp,64
  98:	89aa                	mv	s3,a0
  9a:	84ae                	mv	s1,a1
  9c:	8932                	mv	s2,a2
    int prefix_len = strlen(prefix);
  9e:	00000097          	auipc	ra,0x0
  a2:	3ac080e7          	jalr	940(ra) # 44a <strlen>
  a6:	00050a9b          	sext.w	s5,a0
    int name_len = strlen(name);
  aa:	8526                	mv	a0,s1
  ac:	00000097          	auipc	ra,0x0
  b0:	39e080e7          	jalr	926(ra) # 44a <strlen>
  b4:	0005089b          	sext.w	a7,a0
  b8:	8546                	mv	a0,a7
    int i, j;

    for (i = 0; i < prefix_len; i++) {
  ba:	07505d63          	blez	s5,134 <catdir+0xae>
  be:	8a56                	mv	s4,s5
  c0:	87ce                	mv	a5,s3
  c2:	86ca                	mv	a3,s2
  c4:	0985                	addi	s3,s3,1
  c6:	fffa871b          	addiw	a4,s5,-1
  ca:	1702                	slli	a4,a4,0x20
  cc:	9301                	srli	a4,a4,0x20
  ce:	974e                	add	a4,a4,s3
        buf[i] = prefix[i];
  d0:	0007c803          	lbu	a6,0(a5)
  d4:	01068023          	sb	a6,0(a3)
    for (i = 0; i < prefix_len; i++) {
  d8:	0785                	addi	a5,a5,1
  da:	0685                	addi	a3,a3,1
  dc:	fee79ae3          	bne	a5,a4,d0 <catdir+0x4a>
    }

    buf[i++] = '/';
  e0:	001a061b          	addiw	a2,s4,1
  e4:	0006071b          	sext.w	a4,a2
  e8:	9a4a                	add	s4,s4,s2
  ea:	02f00793          	li	a5,47
  ee:	00fa0023          	sb	a5,0(s4)

    for (j = 0; j < name_len; j++) {
  f2:	02a05563          	blez	a0,11c <catdir+0x96>
  f6:	87a6                	mv	a5,s1
  f8:	974a                	add	a4,a4,s2
  fa:	00148593          	addi	a1,s1,1
  fe:	fff8869b          	addiw	a3,a7,-1
 102:	1682                	slli	a3,a3,0x20
 104:	9281                	srli	a3,a3,0x20
 106:	95b6                	add	a1,a1,a3
        buf[i++] = name[j];
 108:	0007c683          	lbu	a3,0(a5)
 10c:	00d70023          	sb	a3,0(a4)
    for (j = 0; j < name_len; j++) {
 110:	0785                	addi	a5,a5,1
 112:	0705                	addi	a4,a4,1
 114:	feb79ae3          	bne	a5,a1,108 <catdir+0x82>
 118:	0116073b          	addw	a4,a2,a7
    }

    buf[i] = '\0';
 11c:	974a                	add	a4,a4,s2
 11e:	00070023          	sb	zero,0(a4)
}
 122:	70e2                	ld	ra,56(sp)
 124:	7442                	ld	s0,48(sp)
 126:	74a2                	ld	s1,40(sp)
 128:	7902                	ld	s2,32(sp)
 12a:	69e2                	ld	s3,24(sp)
 12c:	6a42                	ld	s4,16(sp)
 12e:	6aa2                	ld	s5,8(sp)
 130:	6121                	addi	sp,sp,64
 132:	8082                	ret
    for (i = 0; i < prefix_len; i++) {
 134:	4a01                	li	s4,0
 136:	b76d                	j	e0 <catdir+0x5a>

0000000000000138 <find>:

void find(int fd, char *dir, char *name) {
 138:	d8010113          	addi	sp,sp,-640
 13c:	26113c23          	sd	ra,632(sp)
 140:	26813823          	sd	s0,624(sp)
 144:	26913423          	sd	s1,616(sp)
 148:	27213023          	sd	s2,608(sp)
 14c:	25313c23          	sd	s3,600(sp)
 150:	25413823          	sd	s4,592(sp)
 154:	25513423          	sd	s5,584(sp)
 158:	25613023          	sd	s6,576(sp)
 15c:	23713c23          	sd	s7,568(sp)
 160:	23813823          	sd	s8,560(sp)
 164:	0500                	addi	s0,sp,640
 166:	84aa                	mv	s1,a0
 168:	89ae                	mv	s3,a1
 16a:	8a32                	mv	s4,a2
    struct dirent de;
  
    while (read(fd, &de, sizeof(de)) == sizeof(de)) {
        if (strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
 16c:	00001917          	auipc	s2,0x1
 170:	a3490913          	addi	s2,s2,-1484 # ba0 <malloc+0xf2>
 174:	00001a97          	auipc	s5,0x1
 178:	a34a8a93          	addi	s5,s5,-1484 # ba8 <malloc+0xfa>
        if (stat(path, &st) < 0) {
            fprintf(2, "find: cannot stat %s\n", path);
            continue;
        }
        
        if (st.type == T_FILE && match(de.name, name)) {
 17c:	4b09                	li	s6,2
            printf("%s\n", path);
        } else if (st.type == T_DIR) {
 17e:	4b85                	li	s7,1
    while (read(fd, &de, sizeof(de)) == sizeof(de)) {
 180:	4641                	li	a2,16
 182:	fa040593          	addi	a1,s0,-96
 186:	8526                	mv	a0,s1
 188:	00000097          	auipc	ra,0x0
 18c:	508080e7          	jalr	1288(ra) # 690 <read>
 190:	47c1                	li	a5,16
 192:	0ef51063          	bne	a0,a5,272 <find+0x13a>
        if (strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
 196:	85ca                	mv	a1,s2
 198:	fa240513          	addi	a0,s0,-94
 19c:	00000097          	auipc	ra,0x0
 1a0:	282080e7          	jalr	642(ra) # 41e <strcmp>
 1a4:	dd71                	beqz	a0,180 <find+0x48>
 1a6:	85d6                	mv	a1,s5
 1a8:	fa240513          	addi	a0,s0,-94
 1ac:	00000097          	auipc	ra,0x0
 1b0:	272080e7          	jalr	626(ra) # 41e <strcmp>
 1b4:	d571                	beqz	a0,180 <find+0x48>
        catdir(dir, de.name, path);
 1b6:	da040613          	addi	a2,s0,-608
 1ba:	fa240593          	addi	a1,s0,-94
 1be:	854e                	mv	a0,s3
 1c0:	00000097          	auipc	ra,0x0
 1c4:	ec6080e7          	jalr	-314(ra) # 86 <catdir>
        if (stat(path, &st) < 0) {
 1c8:	d8840593          	addi	a1,s0,-632
 1cc:	da040513          	addi	a0,s0,-608
 1d0:	00000097          	auipc	ra,0x0
 1d4:	362080e7          	jalr	866(ra) # 532 <stat>
 1d8:	04054263          	bltz	a0,21c <find+0xe4>
        if (st.type == T_FILE && match(de.name, name)) {
 1dc:	d9041783          	lh	a5,-624(s0)
 1e0:	0007871b          	sext.w	a4,a5
 1e4:	05670863          	beq	a4,s6,234 <find+0xfc>
        } else if (st.type == T_DIR) {
 1e8:	2781                	sext.w	a5,a5
 1ea:	f9779be3          	bne	a5,s7,180 <find+0x48>
            int subfd;
            if ((subfd = open(path, 0)) < 0) {
 1ee:	4581                	li	a1,0
 1f0:	da040513          	addi	a0,s0,-608
 1f4:	00000097          	auipc	ra,0x0
 1f8:	4c4080e7          	jalr	1220(ra) # 6b8 <open>
 1fc:	8c2a                	mv	s8,a0
 1fe:	04054e63          	bltz	a0,25a <find+0x122>
                fprintf(2, "find: cannot open %s\n", path);
                continue;
            }
            find(subfd, path, name);
 202:	8652                	mv	a2,s4
 204:	da040593          	addi	a1,s0,-608
 208:	00000097          	auipc	ra,0x0
 20c:	f30080e7          	jalr	-208(ra) # 138 <find>
            close(subfd);
 210:	8562                	mv	a0,s8
 212:	00000097          	auipc	ra,0x0
 216:	48e080e7          	jalr	1166(ra) # 6a0 <close>
 21a:	b79d                	j	180 <find+0x48>
            fprintf(2, "find: cannot stat %s\n", path);
 21c:	da040613          	addi	a2,s0,-608
 220:	00001597          	auipc	a1,0x1
 224:	99058593          	addi	a1,a1,-1648 # bb0 <malloc+0x102>
 228:	855a                	mv	a0,s6
 22a:	00000097          	auipc	ra,0x0
 22e:	798080e7          	jalr	1944(ra) # 9c2 <fprintf>
            continue;
 232:	b7b9                	j	180 <find+0x48>
        if (st.type == T_FILE && match(de.name, name)) {
 234:	85d2                	mv	a1,s4
 236:	fa240513          	addi	a0,s0,-94
 23a:	00000097          	auipc	ra,0x0
 23e:	dc6080e7          	jalr	-570(ra) # 0 <match>
 242:	dd1d                	beqz	a0,180 <find+0x48>
            printf("%s\n", path);
 244:	da040593          	addi	a1,s0,-608
 248:	00001517          	auipc	a0,0x1
 24c:	98050513          	addi	a0,a0,-1664 # bc8 <malloc+0x11a>
 250:	00000097          	auipc	ra,0x0
 254:	7a0080e7          	jalr	1952(ra) # 9f0 <printf>
 258:	b725                	j	180 <find+0x48>
                fprintf(2, "find: cannot open %s\n", path);
 25a:	da040613          	addi	a2,s0,-608
 25e:	00001597          	auipc	a1,0x1
 262:	97258593          	addi	a1,a1,-1678 # bd0 <malloc+0x122>
 266:	855a                	mv	a0,s6
 268:	00000097          	auipc	ra,0x0
 26c:	75a080e7          	jalr	1882(ra) # 9c2 <fprintf>
                continue;
 270:	bf01                	j	180 <find+0x48>
        }
    }
}
 272:	27813083          	ld	ra,632(sp)
 276:	27013403          	ld	s0,624(sp)
 27a:	26813483          	ld	s1,616(sp)
 27e:	26013903          	ld	s2,608(sp)
 282:	25813983          	ld	s3,600(sp)
 286:	25013a03          	ld	s4,592(sp)
 28a:	24813a83          	ld	s5,584(sp)
 28e:	24013b03          	ld	s6,576(sp)
 292:	23813b83          	ld	s7,568(sp)
 296:	23013c03          	ld	s8,560(sp)
 29a:	28010113          	addi	sp,sp,640
 29e:	8082                	ret

00000000000002a0 <main>:

int main(int argc, char *argv[]) {
 2a0:	db010113          	addi	sp,sp,-592
 2a4:	24113423          	sd	ra,584(sp)
 2a8:	24813023          	sd	s0,576(sp)
 2ac:	22913c23          	sd	s1,568(sp)
 2b0:	0c80                	addi	s0,sp,592
    if (argc != 3) {
 2b2:	478d                	li	a5,3
 2b4:	02f50063          	beq	a0,a5,2d4 <main+0x34>
        fprintf(2, "Usage: find dir name\n");
 2b8:	00001597          	auipc	a1,0x1
 2bc:	93058593          	addi	a1,a1,-1744 # be8 <malloc+0x13a>
 2c0:	4509                	li	a0,2
 2c2:	00000097          	auipc	ra,0x0
 2c6:	700080e7          	jalr	1792(ra) # 9c2 <fprintf>
        exit(1);
 2ca:	4505                	li	a0,1
 2cc:	00000097          	auipc	ra,0x0
 2d0:	3ac080e7          	jalr	940(ra) # 678 <exit>
 2d4:	84ae                	mv	s1,a1
    }

    char dir[MAX_PATH];
    char name[DIRSIZ + 1];

    if (strlen(argv[1]) > MAX_PATH - 2 || strlen(argv[2]) > DIRSIZ) {
 2d6:	6588                	ld	a0,8(a1)
 2d8:	00000097          	auipc	ra,0x0
 2dc:	172080e7          	jalr	370(ra) # 44a <strlen>
 2e0:	2501                	sext.w	a0,a0
 2e2:	1fe00793          	li	a5,510
 2e6:	00a7eb63          	bltu	a5,a0,2fc <main+0x5c>
 2ea:	6888                	ld	a0,16(s1)
 2ec:	00000097          	auipc	ra,0x0
 2f0:	15e080e7          	jalr	350(ra) # 44a <strlen>
 2f4:	2501                	sext.w	a0,a0
 2f6:	47b9                	li	a5,14
 2f8:	02a7f063          	bgeu	a5,a0,318 <main+0x78>
        fprintf(2, "dir or name too long...\n");
 2fc:	00001597          	auipc	a1,0x1
 300:	90458593          	addi	a1,a1,-1788 # c00 <malloc+0x152>
 304:	4509                	li	a0,2
 306:	00000097          	auipc	ra,0x0
 30a:	6bc080e7          	jalr	1724(ra) # 9c2 <fprintf>
        exit(1);
 30e:	4505                	li	a0,1
 310:	00000097          	auipc	ra,0x0
 314:	368080e7          	jalr	872(ra) # 678 <exit>
    }

    strcpy(dir, argv[1]);
 318:	648c                	ld	a1,8(s1)
 31a:	de040513          	addi	a0,s0,-544
 31e:	00000097          	auipc	ra,0x0
 322:	0e4080e7          	jalr	228(ra) # 402 <strcpy>
    strcpy(name, argv[2]);
 326:	688c                	ld	a1,16(s1)
 328:	dd040513          	addi	a0,s0,-560
 32c:	00000097          	auipc	ra,0x0
 330:	0d6080e7          	jalr	214(ra) # 402 <strcpy>

    int fd;
    struct stat st;

    if ((fd = open(dir, 0)) < 0) {
 334:	4581                	li	a1,0
 336:	de040513          	addi	a0,s0,-544
 33a:	00000097          	auipc	ra,0x0
 33e:	37e080e7          	jalr	894(ra) # 6b8 <open>
 342:	84aa                	mv	s1,a0
 344:	04054363          	bltz	a0,38a <main+0xea>
        fprintf(2, "find: cannot open %s\n", dir);
        exit(1);
    }

    if (fstat(fd, &st) < 0) {
 348:	db840593          	addi	a1,s0,-584
 34c:	00000097          	auipc	ra,0x0
 350:	384080e7          	jalr	900(ra) # 6d0 <fstat>
 354:	04054b63          	bltz	a0,3aa <main+0x10a>
        fprintf(2, "find: cannot stat %s\n", dir);
        close(fd);
        exit(1);
    }

    if (st.type != T_DIR) {
 358:	dc041703          	lh	a4,-576(s0)
 35c:	4785                	li	a5,1
 35e:	06f70b63          	beq	a4,a5,3d4 <main+0x134>
        printf("%s is not a directory\n", dir);
 362:	de040593          	addi	a1,s0,-544
 366:	00001517          	auipc	a0,0x1
 36a:	8ba50513          	addi	a0,a0,-1862 # c20 <malloc+0x172>
 36e:	00000097          	auipc	ra,0x0
 372:	682080e7          	jalr	1666(ra) # 9f0 <printf>
    } else {
        find(fd, dir, name);
    }

    close(fd);
 376:	8526                	mv	a0,s1
 378:	00000097          	auipc	ra,0x0
 37c:	328080e7          	jalr	808(ra) # 6a0 <close>
    exit(0);
 380:	4501                	li	a0,0
 382:	00000097          	auipc	ra,0x0
 386:	2f6080e7          	jalr	758(ra) # 678 <exit>
        fprintf(2, "find: cannot open %s\n", dir);
 38a:	de040613          	addi	a2,s0,-544
 38e:	00001597          	auipc	a1,0x1
 392:	84258593          	addi	a1,a1,-1982 # bd0 <malloc+0x122>
 396:	4509                	li	a0,2
 398:	00000097          	auipc	ra,0x0
 39c:	62a080e7          	jalr	1578(ra) # 9c2 <fprintf>
        exit(1);
 3a0:	4505                	li	a0,1
 3a2:	00000097          	auipc	ra,0x0
 3a6:	2d6080e7          	jalr	726(ra) # 678 <exit>
        fprintf(2, "find: cannot stat %s\n", dir);
 3aa:	de040613          	addi	a2,s0,-544
 3ae:	00001597          	auipc	a1,0x1
 3b2:	80258593          	addi	a1,a1,-2046 # bb0 <malloc+0x102>
 3b6:	4509                	li	a0,2
 3b8:	00000097          	auipc	ra,0x0
 3bc:	60a080e7          	jalr	1546(ra) # 9c2 <fprintf>
        close(fd);
 3c0:	8526                	mv	a0,s1
 3c2:	00000097          	auipc	ra,0x0
 3c6:	2de080e7          	jalr	734(ra) # 6a0 <close>
        exit(1);
 3ca:	4505                	li	a0,1
 3cc:	00000097          	auipc	ra,0x0
 3d0:	2ac080e7          	jalr	684(ra) # 678 <exit>
        find(fd, dir, name);
 3d4:	dd040613          	addi	a2,s0,-560
 3d8:	de040593          	addi	a1,s0,-544
 3dc:	8526                	mv	a0,s1
 3de:	00000097          	auipc	ra,0x0
 3e2:	d5a080e7          	jalr	-678(ra) # 138 <find>
 3e6:	bf41                	j	376 <main+0xd6>

00000000000003e8 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 3e8:	1141                	addi	sp,sp,-16
 3ea:	e406                	sd	ra,8(sp)
 3ec:	e022                	sd	s0,0(sp)
 3ee:	0800                	addi	s0,sp,16
  extern int main();
  main();
 3f0:	00000097          	auipc	ra,0x0
 3f4:	eb0080e7          	jalr	-336(ra) # 2a0 <main>
  exit(0);
 3f8:	4501                	li	a0,0
 3fa:	00000097          	auipc	ra,0x0
 3fe:	27e080e7          	jalr	638(ra) # 678 <exit>

0000000000000402 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 402:	1141                	addi	sp,sp,-16
 404:	e422                	sd	s0,8(sp)
 406:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 408:	87aa                	mv	a5,a0
 40a:	0585                	addi	a1,a1,1
 40c:	0785                	addi	a5,a5,1
 40e:	fff5c703          	lbu	a4,-1(a1)
 412:	fee78fa3          	sb	a4,-1(a5)
 416:	fb75                	bnez	a4,40a <strcpy+0x8>
    ;
  return os;
}
 418:	6422                	ld	s0,8(sp)
 41a:	0141                	addi	sp,sp,16
 41c:	8082                	ret

000000000000041e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 41e:	1141                	addi	sp,sp,-16
 420:	e422                	sd	s0,8(sp)
 422:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 424:	00054783          	lbu	a5,0(a0)
 428:	cb91                	beqz	a5,43c <strcmp+0x1e>
 42a:	0005c703          	lbu	a4,0(a1)
 42e:	00f71763          	bne	a4,a5,43c <strcmp+0x1e>
    p++, q++;
 432:	0505                	addi	a0,a0,1
 434:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 436:	00054783          	lbu	a5,0(a0)
 43a:	fbe5                	bnez	a5,42a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 43c:	0005c503          	lbu	a0,0(a1)
}
 440:	40a7853b          	subw	a0,a5,a0
 444:	6422                	ld	s0,8(sp)
 446:	0141                	addi	sp,sp,16
 448:	8082                	ret

000000000000044a <strlen>:

uint
strlen(const char *s)
{
 44a:	1141                	addi	sp,sp,-16
 44c:	e422                	sd	s0,8(sp)
 44e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 450:	00054783          	lbu	a5,0(a0)
 454:	cf91                	beqz	a5,470 <strlen+0x26>
 456:	0505                	addi	a0,a0,1
 458:	87aa                	mv	a5,a0
 45a:	4685                	li	a3,1
 45c:	9e89                	subw	a3,a3,a0
 45e:	00f6853b          	addw	a0,a3,a5
 462:	0785                	addi	a5,a5,1
 464:	fff7c703          	lbu	a4,-1(a5)
 468:	fb7d                	bnez	a4,45e <strlen+0x14>
    ;
  return n;
}
 46a:	6422                	ld	s0,8(sp)
 46c:	0141                	addi	sp,sp,16
 46e:	8082                	ret
  for(n = 0; s[n]; n++)
 470:	4501                	li	a0,0
 472:	bfe5                	j	46a <strlen+0x20>

0000000000000474 <memset>:

void*
memset(void *dst, int c, uint n)
{
 474:	1141                	addi	sp,sp,-16
 476:	e422                	sd	s0,8(sp)
 478:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 47a:	ce09                	beqz	a2,494 <memset+0x20>
 47c:	87aa                	mv	a5,a0
 47e:	fff6071b          	addiw	a4,a2,-1
 482:	1702                	slli	a4,a4,0x20
 484:	9301                	srli	a4,a4,0x20
 486:	0705                	addi	a4,a4,1
 488:	972a                	add	a4,a4,a0
    cdst[i] = c;
 48a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 48e:	0785                	addi	a5,a5,1
 490:	fee79de3          	bne	a5,a4,48a <memset+0x16>
  }
  return dst;
}
 494:	6422                	ld	s0,8(sp)
 496:	0141                	addi	sp,sp,16
 498:	8082                	ret

000000000000049a <strchr>:

char*
strchr(const char *s, char c)
{
 49a:	1141                	addi	sp,sp,-16
 49c:	e422                	sd	s0,8(sp)
 49e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 4a0:	00054783          	lbu	a5,0(a0)
 4a4:	cb99                	beqz	a5,4ba <strchr+0x20>
    if(*s == c)
 4a6:	00f58763          	beq	a1,a5,4b4 <strchr+0x1a>
  for(; *s; s++)
 4aa:	0505                	addi	a0,a0,1
 4ac:	00054783          	lbu	a5,0(a0)
 4b0:	fbfd                	bnez	a5,4a6 <strchr+0xc>
      return (char*)s;
  return 0;
 4b2:	4501                	li	a0,0
}
 4b4:	6422                	ld	s0,8(sp)
 4b6:	0141                	addi	sp,sp,16
 4b8:	8082                	ret
  return 0;
 4ba:	4501                	li	a0,0
 4bc:	bfe5                	j	4b4 <strchr+0x1a>

00000000000004be <gets>:

char*
gets(char *buf, int max)
{
 4be:	711d                	addi	sp,sp,-96
 4c0:	ec86                	sd	ra,88(sp)
 4c2:	e8a2                	sd	s0,80(sp)
 4c4:	e4a6                	sd	s1,72(sp)
 4c6:	e0ca                	sd	s2,64(sp)
 4c8:	fc4e                	sd	s3,56(sp)
 4ca:	f852                	sd	s4,48(sp)
 4cc:	f456                	sd	s5,40(sp)
 4ce:	f05a                	sd	s6,32(sp)
 4d0:	ec5e                	sd	s7,24(sp)
 4d2:	1080                	addi	s0,sp,96
 4d4:	8baa                	mv	s7,a0
 4d6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4d8:	892a                	mv	s2,a0
 4da:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 4dc:	4aa9                	li	s5,10
 4de:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 4e0:	89a6                	mv	s3,s1
 4e2:	2485                	addiw	s1,s1,1
 4e4:	0344d863          	bge	s1,s4,514 <gets+0x56>
    cc = read(0, &c, 1);
 4e8:	4605                	li	a2,1
 4ea:	faf40593          	addi	a1,s0,-81
 4ee:	4501                	li	a0,0
 4f0:	00000097          	auipc	ra,0x0
 4f4:	1a0080e7          	jalr	416(ra) # 690 <read>
    if(cc < 1)
 4f8:	00a05e63          	blez	a0,514 <gets+0x56>
    buf[i++] = c;
 4fc:	faf44783          	lbu	a5,-81(s0)
 500:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 504:	01578763          	beq	a5,s5,512 <gets+0x54>
 508:	0905                	addi	s2,s2,1
 50a:	fd679be3          	bne	a5,s6,4e0 <gets+0x22>
  for(i=0; i+1 < max; ){
 50e:	89a6                	mv	s3,s1
 510:	a011                	j	514 <gets+0x56>
 512:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 514:	99de                	add	s3,s3,s7
 516:	00098023          	sb	zero,0(s3)
  return buf;
}
 51a:	855e                	mv	a0,s7
 51c:	60e6                	ld	ra,88(sp)
 51e:	6446                	ld	s0,80(sp)
 520:	64a6                	ld	s1,72(sp)
 522:	6906                	ld	s2,64(sp)
 524:	79e2                	ld	s3,56(sp)
 526:	7a42                	ld	s4,48(sp)
 528:	7aa2                	ld	s5,40(sp)
 52a:	7b02                	ld	s6,32(sp)
 52c:	6be2                	ld	s7,24(sp)
 52e:	6125                	addi	sp,sp,96
 530:	8082                	ret

0000000000000532 <stat>:

int
stat(const char *n, struct stat *st)
{
 532:	1101                	addi	sp,sp,-32
 534:	ec06                	sd	ra,24(sp)
 536:	e822                	sd	s0,16(sp)
 538:	e426                	sd	s1,8(sp)
 53a:	e04a                	sd	s2,0(sp)
 53c:	1000                	addi	s0,sp,32
 53e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 540:	4581                	li	a1,0
 542:	00000097          	auipc	ra,0x0
 546:	176080e7          	jalr	374(ra) # 6b8 <open>
  if(fd < 0)
 54a:	02054563          	bltz	a0,574 <stat+0x42>
 54e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 550:	85ca                	mv	a1,s2
 552:	00000097          	auipc	ra,0x0
 556:	17e080e7          	jalr	382(ra) # 6d0 <fstat>
 55a:	892a                	mv	s2,a0
  close(fd);
 55c:	8526                	mv	a0,s1
 55e:	00000097          	auipc	ra,0x0
 562:	142080e7          	jalr	322(ra) # 6a0 <close>
  return r;
}
 566:	854a                	mv	a0,s2
 568:	60e2                	ld	ra,24(sp)
 56a:	6442                	ld	s0,16(sp)
 56c:	64a2                	ld	s1,8(sp)
 56e:	6902                	ld	s2,0(sp)
 570:	6105                	addi	sp,sp,32
 572:	8082                	ret
    return -1;
 574:	597d                	li	s2,-1
 576:	bfc5                	j	566 <stat+0x34>

0000000000000578 <atoi>:

int
atoi(const char *s)
{
 578:	1141                	addi	sp,sp,-16
 57a:	e422                	sd	s0,8(sp)
 57c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 57e:	00054603          	lbu	a2,0(a0)
 582:	fd06079b          	addiw	a5,a2,-48
 586:	0ff7f793          	andi	a5,a5,255
 58a:	4725                	li	a4,9
 58c:	02f76963          	bltu	a4,a5,5be <atoi+0x46>
 590:	86aa                	mv	a3,a0
  n = 0;
 592:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 594:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 596:	0685                	addi	a3,a3,1
 598:	0025179b          	slliw	a5,a0,0x2
 59c:	9fa9                	addw	a5,a5,a0
 59e:	0017979b          	slliw	a5,a5,0x1
 5a2:	9fb1                	addw	a5,a5,a2
 5a4:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 5a8:	0006c603          	lbu	a2,0(a3)
 5ac:	fd06071b          	addiw	a4,a2,-48
 5b0:	0ff77713          	andi	a4,a4,255
 5b4:	fee5f1e3          	bgeu	a1,a4,596 <atoi+0x1e>
  return n;
}
 5b8:	6422                	ld	s0,8(sp)
 5ba:	0141                	addi	sp,sp,16
 5bc:	8082                	ret
  n = 0;
 5be:	4501                	li	a0,0
 5c0:	bfe5                	j	5b8 <atoi+0x40>

00000000000005c2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 5c2:	1141                	addi	sp,sp,-16
 5c4:	e422                	sd	s0,8(sp)
 5c6:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 5c8:	02b57663          	bgeu	a0,a1,5f4 <memmove+0x32>
    while(n-- > 0)
 5cc:	02c05163          	blez	a2,5ee <memmove+0x2c>
 5d0:	fff6079b          	addiw	a5,a2,-1
 5d4:	1782                	slli	a5,a5,0x20
 5d6:	9381                	srli	a5,a5,0x20
 5d8:	0785                	addi	a5,a5,1
 5da:	97aa                	add	a5,a5,a0
  dst = vdst;
 5dc:	872a                	mv	a4,a0
      *dst++ = *src++;
 5de:	0585                	addi	a1,a1,1
 5e0:	0705                	addi	a4,a4,1
 5e2:	fff5c683          	lbu	a3,-1(a1)
 5e6:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 5ea:	fee79ae3          	bne	a5,a4,5de <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 5ee:	6422                	ld	s0,8(sp)
 5f0:	0141                	addi	sp,sp,16
 5f2:	8082                	ret
    dst += n;
 5f4:	00c50733          	add	a4,a0,a2
    src += n;
 5f8:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 5fa:	fec05ae3          	blez	a2,5ee <memmove+0x2c>
 5fe:	fff6079b          	addiw	a5,a2,-1
 602:	1782                	slli	a5,a5,0x20
 604:	9381                	srli	a5,a5,0x20
 606:	fff7c793          	not	a5,a5
 60a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 60c:	15fd                	addi	a1,a1,-1
 60e:	177d                	addi	a4,a4,-1
 610:	0005c683          	lbu	a3,0(a1)
 614:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 618:	fee79ae3          	bne	a5,a4,60c <memmove+0x4a>
 61c:	bfc9                	j	5ee <memmove+0x2c>

000000000000061e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 61e:	1141                	addi	sp,sp,-16
 620:	e422                	sd	s0,8(sp)
 622:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 624:	ca05                	beqz	a2,654 <memcmp+0x36>
 626:	fff6069b          	addiw	a3,a2,-1
 62a:	1682                	slli	a3,a3,0x20
 62c:	9281                	srli	a3,a3,0x20
 62e:	0685                	addi	a3,a3,1
 630:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 632:	00054783          	lbu	a5,0(a0)
 636:	0005c703          	lbu	a4,0(a1)
 63a:	00e79863          	bne	a5,a4,64a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 63e:	0505                	addi	a0,a0,1
    p2++;
 640:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 642:	fed518e3          	bne	a0,a3,632 <memcmp+0x14>
  }
  return 0;
 646:	4501                	li	a0,0
 648:	a019                	j	64e <memcmp+0x30>
      return *p1 - *p2;
 64a:	40e7853b          	subw	a0,a5,a4
}
 64e:	6422                	ld	s0,8(sp)
 650:	0141                	addi	sp,sp,16
 652:	8082                	ret
  return 0;
 654:	4501                	li	a0,0
 656:	bfe5                	j	64e <memcmp+0x30>

0000000000000658 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 658:	1141                	addi	sp,sp,-16
 65a:	e406                	sd	ra,8(sp)
 65c:	e022                	sd	s0,0(sp)
 65e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 660:	00000097          	auipc	ra,0x0
 664:	f62080e7          	jalr	-158(ra) # 5c2 <memmove>
}
 668:	60a2                	ld	ra,8(sp)
 66a:	6402                	ld	s0,0(sp)
 66c:	0141                	addi	sp,sp,16
 66e:	8082                	ret

0000000000000670 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 670:	4885                	li	a7,1
 ecall
 672:	00000073          	ecall
 ret
 676:	8082                	ret

0000000000000678 <exit>:
.global exit
exit:
 li a7, SYS_exit
 678:	4889                	li	a7,2
 ecall
 67a:	00000073          	ecall
 ret
 67e:	8082                	ret

0000000000000680 <wait>:
.global wait
wait:
 li a7, SYS_wait
 680:	488d                	li	a7,3
 ecall
 682:	00000073          	ecall
 ret
 686:	8082                	ret

0000000000000688 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 688:	4891                	li	a7,4
 ecall
 68a:	00000073          	ecall
 ret
 68e:	8082                	ret

0000000000000690 <read>:
.global read
read:
 li a7, SYS_read
 690:	4895                	li	a7,5
 ecall
 692:	00000073          	ecall
 ret
 696:	8082                	ret

0000000000000698 <write>:
.global write
write:
 li a7, SYS_write
 698:	48c1                	li	a7,16
 ecall
 69a:	00000073          	ecall
 ret
 69e:	8082                	ret

00000000000006a0 <close>:
.global close
close:
 li a7, SYS_close
 6a0:	48d5                	li	a7,21
 ecall
 6a2:	00000073          	ecall
 ret
 6a6:	8082                	ret

00000000000006a8 <kill>:
.global kill
kill:
 li a7, SYS_kill
 6a8:	4899                	li	a7,6
 ecall
 6aa:	00000073          	ecall
 ret
 6ae:	8082                	ret

00000000000006b0 <exec>:
.global exec
exec:
 li a7, SYS_exec
 6b0:	489d                	li	a7,7
 ecall
 6b2:	00000073          	ecall
 ret
 6b6:	8082                	ret

00000000000006b8 <open>:
.global open
open:
 li a7, SYS_open
 6b8:	48bd                	li	a7,15
 ecall
 6ba:	00000073          	ecall
 ret
 6be:	8082                	ret

00000000000006c0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6c0:	48c5                	li	a7,17
 ecall
 6c2:	00000073          	ecall
 ret
 6c6:	8082                	ret

00000000000006c8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 6c8:	48c9                	li	a7,18
 ecall
 6ca:	00000073          	ecall
 ret
 6ce:	8082                	ret

00000000000006d0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 6d0:	48a1                	li	a7,8
 ecall
 6d2:	00000073          	ecall
 ret
 6d6:	8082                	ret

00000000000006d8 <link>:
.global link
link:
 li a7, SYS_link
 6d8:	48cd                	li	a7,19
 ecall
 6da:	00000073          	ecall
 ret
 6de:	8082                	ret

00000000000006e0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6e0:	48d1                	li	a7,20
 ecall
 6e2:	00000073          	ecall
 ret
 6e6:	8082                	ret

00000000000006e8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6e8:	48a5                	li	a7,9
 ecall
 6ea:	00000073          	ecall
 ret
 6ee:	8082                	ret

00000000000006f0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 6f0:	48a9                	li	a7,10
 ecall
 6f2:	00000073          	ecall
 ret
 6f6:	8082                	ret

00000000000006f8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 6f8:	48ad                	li	a7,11
 ecall
 6fa:	00000073          	ecall
 ret
 6fe:	8082                	ret

0000000000000700 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 700:	48b1                	li	a7,12
 ecall
 702:	00000073          	ecall
 ret
 706:	8082                	ret

0000000000000708 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 708:	48b5                	li	a7,13
 ecall
 70a:	00000073          	ecall
 ret
 70e:	8082                	ret

0000000000000710 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 710:	48b9                	li	a7,14
 ecall
 712:	00000073          	ecall
 ret
 716:	8082                	ret

0000000000000718 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 718:	1101                	addi	sp,sp,-32
 71a:	ec06                	sd	ra,24(sp)
 71c:	e822                	sd	s0,16(sp)
 71e:	1000                	addi	s0,sp,32
 720:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 724:	4605                	li	a2,1
 726:	fef40593          	addi	a1,s0,-17
 72a:	00000097          	auipc	ra,0x0
 72e:	f6e080e7          	jalr	-146(ra) # 698 <write>
}
 732:	60e2                	ld	ra,24(sp)
 734:	6442                	ld	s0,16(sp)
 736:	6105                	addi	sp,sp,32
 738:	8082                	ret

000000000000073a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 73a:	7139                	addi	sp,sp,-64
 73c:	fc06                	sd	ra,56(sp)
 73e:	f822                	sd	s0,48(sp)
 740:	f426                	sd	s1,40(sp)
 742:	f04a                	sd	s2,32(sp)
 744:	ec4e                	sd	s3,24(sp)
 746:	0080                	addi	s0,sp,64
 748:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 74a:	c299                	beqz	a3,750 <printint+0x16>
 74c:	0805c863          	bltz	a1,7dc <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 750:	2581                	sext.w	a1,a1
  neg = 0;
 752:	4881                	li	a7,0
 754:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 758:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 75a:	2601                	sext.w	a2,a2
 75c:	00000517          	auipc	a0,0x0
 760:	4e450513          	addi	a0,a0,1252 # c40 <digits>
 764:	883a                	mv	a6,a4
 766:	2705                	addiw	a4,a4,1
 768:	02c5f7bb          	remuw	a5,a1,a2
 76c:	1782                	slli	a5,a5,0x20
 76e:	9381                	srli	a5,a5,0x20
 770:	97aa                	add	a5,a5,a0
 772:	0007c783          	lbu	a5,0(a5)
 776:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 77a:	0005879b          	sext.w	a5,a1
 77e:	02c5d5bb          	divuw	a1,a1,a2
 782:	0685                	addi	a3,a3,1
 784:	fec7f0e3          	bgeu	a5,a2,764 <printint+0x2a>
  if(neg)
 788:	00088b63          	beqz	a7,79e <printint+0x64>
    buf[i++] = '-';
 78c:	fd040793          	addi	a5,s0,-48
 790:	973e                	add	a4,a4,a5
 792:	02d00793          	li	a5,45
 796:	fef70823          	sb	a5,-16(a4)
 79a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 79e:	02e05863          	blez	a4,7ce <printint+0x94>
 7a2:	fc040793          	addi	a5,s0,-64
 7a6:	00e78933          	add	s2,a5,a4
 7aa:	fff78993          	addi	s3,a5,-1
 7ae:	99ba                	add	s3,s3,a4
 7b0:	377d                	addiw	a4,a4,-1
 7b2:	1702                	slli	a4,a4,0x20
 7b4:	9301                	srli	a4,a4,0x20
 7b6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 7ba:	fff94583          	lbu	a1,-1(s2)
 7be:	8526                	mv	a0,s1
 7c0:	00000097          	auipc	ra,0x0
 7c4:	f58080e7          	jalr	-168(ra) # 718 <putc>
  while(--i >= 0)
 7c8:	197d                	addi	s2,s2,-1
 7ca:	ff3918e3          	bne	s2,s3,7ba <printint+0x80>
}
 7ce:	70e2                	ld	ra,56(sp)
 7d0:	7442                	ld	s0,48(sp)
 7d2:	74a2                	ld	s1,40(sp)
 7d4:	7902                	ld	s2,32(sp)
 7d6:	69e2                	ld	s3,24(sp)
 7d8:	6121                	addi	sp,sp,64
 7da:	8082                	ret
    x = -xx;
 7dc:	40b005bb          	negw	a1,a1
    neg = 1;
 7e0:	4885                	li	a7,1
    x = -xx;
 7e2:	bf8d                	j	754 <printint+0x1a>

00000000000007e4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7e4:	7119                	addi	sp,sp,-128
 7e6:	fc86                	sd	ra,120(sp)
 7e8:	f8a2                	sd	s0,112(sp)
 7ea:	f4a6                	sd	s1,104(sp)
 7ec:	f0ca                	sd	s2,96(sp)
 7ee:	ecce                	sd	s3,88(sp)
 7f0:	e8d2                	sd	s4,80(sp)
 7f2:	e4d6                	sd	s5,72(sp)
 7f4:	e0da                	sd	s6,64(sp)
 7f6:	fc5e                	sd	s7,56(sp)
 7f8:	f862                	sd	s8,48(sp)
 7fa:	f466                	sd	s9,40(sp)
 7fc:	f06a                	sd	s10,32(sp)
 7fe:	ec6e                	sd	s11,24(sp)
 800:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 802:	0005c903          	lbu	s2,0(a1)
 806:	18090f63          	beqz	s2,9a4 <vprintf+0x1c0>
 80a:	8aaa                	mv	s5,a0
 80c:	8b32                	mv	s6,a2
 80e:	00158493          	addi	s1,a1,1
  state = 0;
 812:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 814:	02500a13          	li	s4,37
      if(c == 'd'){
 818:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 81c:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 820:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 824:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 828:	00000b97          	auipc	s7,0x0
 82c:	418b8b93          	addi	s7,s7,1048 # c40 <digits>
 830:	a839                	j	84e <vprintf+0x6a>
        putc(fd, c);
 832:	85ca                	mv	a1,s2
 834:	8556                	mv	a0,s5
 836:	00000097          	auipc	ra,0x0
 83a:	ee2080e7          	jalr	-286(ra) # 718 <putc>
 83e:	a019                	j	844 <vprintf+0x60>
    } else if(state == '%'){
 840:	01498f63          	beq	s3,s4,85e <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 844:	0485                	addi	s1,s1,1
 846:	fff4c903          	lbu	s2,-1(s1)
 84a:	14090d63          	beqz	s2,9a4 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 84e:	0009079b          	sext.w	a5,s2
    if(state == 0){
 852:	fe0997e3          	bnez	s3,840 <vprintf+0x5c>
      if(c == '%'){
 856:	fd479ee3          	bne	a5,s4,832 <vprintf+0x4e>
        state = '%';
 85a:	89be                	mv	s3,a5
 85c:	b7e5                	j	844 <vprintf+0x60>
      if(c == 'd'){
 85e:	05878063          	beq	a5,s8,89e <vprintf+0xba>
      } else if(c == 'l') {
 862:	05978c63          	beq	a5,s9,8ba <vprintf+0xd6>
      } else if(c == 'x') {
 866:	07a78863          	beq	a5,s10,8d6 <vprintf+0xf2>
      } else if(c == 'p') {
 86a:	09b78463          	beq	a5,s11,8f2 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 86e:	07300713          	li	a4,115
 872:	0ce78663          	beq	a5,a4,93e <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 876:	06300713          	li	a4,99
 87a:	0ee78e63          	beq	a5,a4,976 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 87e:	11478863          	beq	a5,s4,98e <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 882:	85d2                	mv	a1,s4
 884:	8556                	mv	a0,s5
 886:	00000097          	auipc	ra,0x0
 88a:	e92080e7          	jalr	-366(ra) # 718 <putc>
        putc(fd, c);
 88e:	85ca                	mv	a1,s2
 890:	8556                	mv	a0,s5
 892:	00000097          	auipc	ra,0x0
 896:	e86080e7          	jalr	-378(ra) # 718 <putc>
      }
      state = 0;
 89a:	4981                	li	s3,0
 89c:	b765                	j	844 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 89e:	008b0913          	addi	s2,s6,8
 8a2:	4685                	li	a3,1
 8a4:	4629                	li	a2,10
 8a6:	000b2583          	lw	a1,0(s6)
 8aa:	8556                	mv	a0,s5
 8ac:	00000097          	auipc	ra,0x0
 8b0:	e8e080e7          	jalr	-370(ra) # 73a <printint>
 8b4:	8b4a                	mv	s6,s2
      state = 0;
 8b6:	4981                	li	s3,0
 8b8:	b771                	j	844 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8ba:	008b0913          	addi	s2,s6,8
 8be:	4681                	li	a3,0
 8c0:	4629                	li	a2,10
 8c2:	000b2583          	lw	a1,0(s6)
 8c6:	8556                	mv	a0,s5
 8c8:	00000097          	auipc	ra,0x0
 8cc:	e72080e7          	jalr	-398(ra) # 73a <printint>
 8d0:	8b4a                	mv	s6,s2
      state = 0;
 8d2:	4981                	li	s3,0
 8d4:	bf85                	j	844 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 8d6:	008b0913          	addi	s2,s6,8
 8da:	4681                	li	a3,0
 8dc:	4641                	li	a2,16
 8de:	000b2583          	lw	a1,0(s6)
 8e2:	8556                	mv	a0,s5
 8e4:	00000097          	auipc	ra,0x0
 8e8:	e56080e7          	jalr	-426(ra) # 73a <printint>
 8ec:	8b4a                	mv	s6,s2
      state = 0;
 8ee:	4981                	li	s3,0
 8f0:	bf91                	j	844 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 8f2:	008b0793          	addi	a5,s6,8
 8f6:	f8f43423          	sd	a5,-120(s0)
 8fa:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 8fe:	03000593          	li	a1,48
 902:	8556                	mv	a0,s5
 904:	00000097          	auipc	ra,0x0
 908:	e14080e7          	jalr	-492(ra) # 718 <putc>
  putc(fd, 'x');
 90c:	85ea                	mv	a1,s10
 90e:	8556                	mv	a0,s5
 910:	00000097          	auipc	ra,0x0
 914:	e08080e7          	jalr	-504(ra) # 718 <putc>
 918:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 91a:	03c9d793          	srli	a5,s3,0x3c
 91e:	97de                	add	a5,a5,s7
 920:	0007c583          	lbu	a1,0(a5)
 924:	8556                	mv	a0,s5
 926:	00000097          	auipc	ra,0x0
 92a:	df2080e7          	jalr	-526(ra) # 718 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 92e:	0992                	slli	s3,s3,0x4
 930:	397d                	addiw	s2,s2,-1
 932:	fe0914e3          	bnez	s2,91a <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 936:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 93a:	4981                	li	s3,0
 93c:	b721                	j	844 <vprintf+0x60>
        s = va_arg(ap, char*);
 93e:	008b0993          	addi	s3,s6,8
 942:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 946:	02090163          	beqz	s2,968 <vprintf+0x184>
        while(*s != 0){
 94a:	00094583          	lbu	a1,0(s2)
 94e:	c9a1                	beqz	a1,99e <vprintf+0x1ba>
          putc(fd, *s);
 950:	8556                	mv	a0,s5
 952:	00000097          	auipc	ra,0x0
 956:	dc6080e7          	jalr	-570(ra) # 718 <putc>
          s++;
 95a:	0905                	addi	s2,s2,1
        while(*s != 0){
 95c:	00094583          	lbu	a1,0(s2)
 960:	f9e5                	bnez	a1,950 <vprintf+0x16c>
        s = va_arg(ap, char*);
 962:	8b4e                	mv	s6,s3
      state = 0;
 964:	4981                	li	s3,0
 966:	bdf9                	j	844 <vprintf+0x60>
          s = "(null)";
 968:	00000917          	auipc	s2,0x0
 96c:	2d090913          	addi	s2,s2,720 # c38 <malloc+0x18a>
        while(*s != 0){
 970:	02800593          	li	a1,40
 974:	bff1                	j	950 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 976:	008b0913          	addi	s2,s6,8
 97a:	000b4583          	lbu	a1,0(s6)
 97e:	8556                	mv	a0,s5
 980:	00000097          	auipc	ra,0x0
 984:	d98080e7          	jalr	-616(ra) # 718 <putc>
 988:	8b4a                	mv	s6,s2
      state = 0;
 98a:	4981                	li	s3,0
 98c:	bd65                	j	844 <vprintf+0x60>
        putc(fd, c);
 98e:	85d2                	mv	a1,s4
 990:	8556                	mv	a0,s5
 992:	00000097          	auipc	ra,0x0
 996:	d86080e7          	jalr	-634(ra) # 718 <putc>
      state = 0;
 99a:	4981                	li	s3,0
 99c:	b565                	j	844 <vprintf+0x60>
        s = va_arg(ap, char*);
 99e:	8b4e                	mv	s6,s3
      state = 0;
 9a0:	4981                	li	s3,0
 9a2:	b54d                	j	844 <vprintf+0x60>
    }
  }
}
 9a4:	70e6                	ld	ra,120(sp)
 9a6:	7446                	ld	s0,112(sp)
 9a8:	74a6                	ld	s1,104(sp)
 9aa:	7906                	ld	s2,96(sp)
 9ac:	69e6                	ld	s3,88(sp)
 9ae:	6a46                	ld	s4,80(sp)
 9b0:	6aa6                	ld	s5,72(sp)
 9b2:	6b06                	ld	s6,64(sp)
 9b4:	7be2                	ld	s7,56(sp)
 9b6:	7c42                	ld	s8,48(sp)
 9b8:	7ca2                	ld	s9,40(sp)
 9ba:	7d02                	ld	s10,32(sp)
 9bc:	6de2                	ld	s11,24(sp)
 9be:	6109                	addi	sp,sp,128
 9c0:	8082                	ret

00000000000009c2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9c2:	715d                	addi	sp,sp,-80
 9c4:	ec06                	sd	ra,24(sp)
 9c6:	e822                	sd	s0,16(sp)
 9c8:	1000                	addi	s0,sp,32
 9ca:	e010                	sd	a2,0(s0)
 9cc:	e414                	sd	a3,8(s0)
 9ce:	e818                	sd	a4,16(s0)
 9d0:	ec1c                	sd	a5,24(s0)
 9d2:	03043023          	sd	a6,32(s0)
 9d6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 9da:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9de:	8622                	mv	a2,s0
 9e0:	00000097          	auipc	ra,0x0
 9e4:	e04080e7          	jalr	-508(ra) # 7e4 <vprintf>
}
 9e8:	60e2                	ld	ra,24(sp)
 9ea:	6442                	ld	s0,16(sp)
 9ec:	6161                	addi	sp,sp,80
 9ee:	8082                	ret

00000000000009f0 <printf>:

void
printf(const char *fmt, ...)
{
 9f0:	711d                	addi	sp,sp,-96
 9f2:	ec06                	sd	ra,24(sp)
 9f4:	e822                	sd	s0,16(sp)
 9f6:	1000                	addi	s0,sp,32
 9f8:	e40c                	sd	a1,8(s0)
 9fa:	e810                	sd	a2,16(s0)
 9fc:	ec14                	sd	a3,24(s0)
 9fe:	f018                	sd	a4,32(s0)
 a00:	f41c                	sd	a5,40(s0)
 a02:	03043823          	sd	a6,48(s0)
 a06:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a0a:	00840613          	addi	a2,s0,8
 a0e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a12:	85aa                	mv	a1,a0
 a14:	4505                	li	a0,1
 a16:	00000097          	auipc	ra,0x0
 a1a:	dce080e7          	jalr	-562(ra) # 7e4 <vprintf>
}
 a1e:	60e2                	ld	ra,24(sp)
 a20:	6442                	ld	s0,16(sp)
 a22:	6125                	addi	sp,sp,96
 a24:	8082                	ret

0000000000000a26 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a26:	1141                	addi	sp,sp,-16
 a28:	e422                	sd	s0,8(sp)
 a2a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a2c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a30:	00000797          	auipc	a5,0x0
 a34:	5d07b783          	ld	a5,1488(a5) # 1000 <freep>
 a38:	a805                	j	a68 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a3a:	4618                	lw	a4,8(a2)
 a3c:	9db9                	addw	a1,a1,a4
 a3e:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a42:	6398                	ld	a4,0(a5)
 a44:	6318                	ld	a4,0(a4)
 a46:	fee53823          	sd	a4,-16(a0)
 a4a:	a091                	j	a8e <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a4c:	ff852703          	lw	a4,-8(a0)
 a50:	9e39                	addw	a2,a2,a4
 a52:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 a54:	ff053703          	ld	a4,-16(a0)
 a58:	e398                	sd	a4,0(a5)
 a5a:	a099                	j	aa0 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a5c:	6398                	ld	a4,0(a5)
 a5e:	00e7e463          	bltu	a5,a4,a66 <free+0x40>
 a62:	00e6ea63          	bltu	a3,a4,a76 <free+0x50>
{
 a66:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a68:	fed7fae3          	bgeu	a5,a3,a5c <free+0x36>
 a6c:	6398                	ld	a4,0(a5)
 a6e:	00e6e463          	bltu	a3,a4,a76 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a72:	fee7eae3          	bltu	a5,a4,a66 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 a76:	ff852583          	lw	a1,-8(a0)
 a7a:	6390                	ld	a2,0(a5)
 a7c:	02059713          	slli	a4,a1,0x20
 a80:	9301                	srli	a4,a4,0x20
 a82:	0712                	slli	a4,a4,0x4
 a84:	9736                	add	a4,a4,a3
 a86:	fae60ae3          	beq	a2,a4,a3a <free+0x14>
    bp->s.ptr = p->s.ptr;
 a8a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a8e:	4790                	lw	a2,8(a5)
 a90:	02061713          	slli	a4,a2,0x20
 a94:	9301                	srli	a4,a4,0x20
 a96:	0712                	slli	a4,a4,0x4
 a98:	973e                	add	a4,a4,a5
 a9a:	fae689e3          	beq	a3,a4,a4c <free+0x26>
  } else
    p->s.ptr = bp;
 a9e:	e394                	sd	a3,0(a5)
  freep = p;
 aa0:	00000717          	auipc	a4,0x0
 aa4:	56f73023          	sd	a5,1376(a4) # 1000 <freep>
}
 aa8:	6422                	ld	s0,8(sp)
 aaa:	0141                	addi	sp,sp,16
 aac:	8082                	ret

0000000000000aae <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 aae:	7139                	addi	sp,sp,-64
 ab0:	fc06                	sd	ra,56(sp)
 ab2:	f822                	sd	s0,48(sp)
 ab4:	f426                	sd	s1,40(sp)
 ab6:	f04a                	sd	s2,32(sp)
 ab8:	ec4e                	sd	s3,24(sp)
 aba:	e852                	sd	s4,16(sp)
 abc:	e456                	sd	s5,8(sp)
 abe:	e05a                	sd	s6,0(sp)
 ac0:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ac2:	02051493          	slli	s1,a0,0x20
 ac6:	9081                	srli	s1,s1,0x20
 ac8:	04bd                	addi	s1,s1,15
 aca:	8091                	srli	s1,s1,0x4
 acc:	0014899b          	addiw	s3,s1,1
 ad0:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 ad2:	00000517          	auipc	a0,0x0
 ad6:	52e53503          	ld	a0,1326(a0) # 1000 <freep>
 ada:	c515                	beqz	a0,b06 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 adc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ade:	4798                	lw	a4,8(a5)
 ae0:	02977f63          	bgeu	a4,s1,b1e <malloc+0x70>
 ae4:	8a4e                	mv	s4,s3
 ae6:	0009871b          	sext.w	a4,s3
 aea:	6685                	lui	a3,0x1
 aec:	00d77363          	bgeu	a4,a3,af2 <malloc+0x44>
 af0:	6a05                	lui	s4,0x1
 af2:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 af6:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 afa:	00000917          	auipc	s2,0x0
 afe:	50690913          	addi	s2,s2,1286 # 1000 <freep>
  if(p == (char*)-1)
 b02:	5afd                	li	s5,-1
 b04:	a88d                	j	b76 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 b06:	00000797          	auipc	a5,0x0
 b0a:	50a78793          	addi	a5,a5,1290 # 1010 <base>
 b0e:	00000717          	auipc	a4,0x0
 b12:	4ef73923          	sd	a5,1266(a4) # 1000 <freep>
 b16:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b18:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b1c:	b7e1                	j	ae4 <malloc+0x36>
      if(p->s.size == nunits)
 b1e:	02e48b63          	beq	s1,a4,b54 <malloc+0xa6>
        p->s.size -= nunits;
 b22:	4137073b          	subw	a4,a4,s3
 b26:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b28:	1702                	slli	a4,a4,0x20
 b2a:	9301                	srli	a4,a4,0x20
 b2c:	0712                	slli	a4,a4,0x4
 b2e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b30:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b34:	00000717          	auipc	a4,0x0
 b38:	4ca73623          	sd	a0,1228(a4) # 1000 <freep>
      return (void*)(p + 1);
 b3c:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 b40:	70e2                	ld	ra,56(sp)
 b42:	7442                	ld	s0,48(sp)
 b44:	74a2                	ld	s1,40(sp)
 b46:	7902                	ld	s2,32(sp)
 b48:	69e2                	ld	s3,24(sp)
 b4a:	6a42                	ld	s4,16(sp)
 b4c:	6aa2                	ld	s5,8(sp)
 b4e:	6b02                	ld	s6,0(sp)
 b50:	6121                	addi	sp,sp,64
 b52:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 b54:	6398                	ld	a4,0(a5)
 b56:	e118                	sd	a4,0(a0)
 b58:	bff1                	j	b34 <malloc+0x86>
  hp->s.size = nu;
 b5a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b5e:	0541                	addi	a0,a0,16
 b60:	00000097          	auipc	ra,0x0
 b64:	ec6080e7          	jalr	-314(ra) # a26 <free>
  return freep;
 b68:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b6c:	d971                	beqz	a0,b40 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b6e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b70:	4798                	lw	a4,8(a5)
 b72:	fa9776e3          	bgeu	a4,s1,b1e <malloc+0x70>
    if(p == freep)
 b76:	00093703          	ld	a4,0(s2)
 b7a:	853e                	mv	a0,a5
 b7c:	fef719e3          	bne	a4,a5,b6e <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 b80:	8552                	mv	a0,s4
 b82:	00000097          	auipc	ra,0x0
 b86:	b7e080e7          	jalr	-1154(ra) # 700 <sbrk>
  if(p == (char*)-1)
 b8a:	fd5518e3          	bne	a0,s5,b5a <malloc+0xac>
        return 0;
 b8e:	4501                	li	a0,0
 b90:	bf45                	j	b40 <malloc+0x92>
