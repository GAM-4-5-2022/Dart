mod_lines=set()
br=0
for line in open('HR_Txt-624.txt','r'):
    br+=1
    if str(br)[len(str(br))-5:]=='00000':
        print(br)
    word=line[:line.find('	')]
    if len(word)==5:
        mod_lines.add(word+'\n')


f=open('output.txt','w')
f.writelines(mod_lines)
f.close()
