mod_lines = set()
br = 0
alphabet = ['a', 'b', 'c', 'č', 'ć', 'd', 'dž', 'đ', 'e', 'f', 'g', 'h', 'i', 'j',
            'k', 'l', 'lj', 'm', 'n', 'nj', 'o', 'p', 'r', 's', 'š', 't', 'u', 'v', 'z', 'ž']
double = ['dž', 'lj', 'nj']
lock = False
for line in open('source/savewl_hrwac_20220328190754.xml', 'r'):
    br += 1
    if str(br)[len(str(br))-6:] == '000000':
        print(br)
    if 'str' in line:
        ok = True
        word = line[line.find('>')+1:line.find('</')]
        req = 5
        for i in word:
            if i not in alphabet:
                ok = False
        for i in double:
            req += word.count(i)
        if (len(word) == req) and ok:
            string = word.lower()
            lock = True
    elif 'freq' in line and lock:
        freq = line[line.find('>')+1:line.find('</')]
        mod_lines.add(string+';'+freq+'\n')
        lock = False

mod_lines = sorted(mod_lines, key=lambda line: int(
    line[line.find(';')+1:line.find('\n')]), reverse=True)
f = open('assets/words.txt', 'w')
f.writelines(mod_lines)
f.close()
