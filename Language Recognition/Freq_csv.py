name ="Freq2.csv"
lang=[]
for line in open (name):
    fields = line.split(",")
    name = fields[0]
    a = float (fields[1])
    b = float (fields[2])
    c = float (fields[3])
    d = float (fields[4])
    e = float (fields[5])
    f = float (fields[6])
    g = float (fields[7])
    h = float (fields[8])
    i = float (fields[9])
    j = float (fields[10])
    k = float (fields[11])
    l = float (fields[12])
    m = float (fields[13])
    n = float (fields[14])
    o = float (fields[15])
    p = float (fields[16])
    q = float (fields[17])
    r = float (fields[18])
    s = float (fields[19])
    t = float (fields[20])
    u = float (fields[21])
    v = float (fields[22])
    w = float (fields[23])
    x = float (fields[24])
    y = float (fields[25])
    z = float (fields[26])
    s1 = float (fields[27])
    s2 = float (fields[28])
    s3 = float (fields[29])
    s4 = float (fields[30])
    s5 = float (fields[31])
    s6 = float (fields[32])
    s7 = float (fields[33])
    s8 = float (fields[34])
    s9 = float (fields[35])
    s10 = float (fields[36])
    s11 = float (fields[37])
    s12 = float (fields[38])
    s13 = float (fields[39])
    s14 = float (fields[40])
    s15 = float (fields[41])
    s16 = float (fields[42])
    s17 = float (fields[43])
    s18 = float (fields[44])
    s19 = float (fields[45])
    s20 = float (fields[46])
    s21 = float (fields[47])
    s22 = float (fields[48])
    s23 = float (fields[49])
    s24 = float (fields[50])
    s25 = float (fields[51])
    s26 = float (fields[52])
    s27 = float (fields[53])
    s28 = float (fields[54])
    s29 = float (fields[55])

    letter = (name, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29)
    lang.append(letter)
#input file text as string
with open ("text.txt", "r") as myfile:
    text=myfile.read().replace('\n', '')
    
#sort letter counts
count = 0
letters = []
for i in range(55):
    letters.append(0)
       
for x in range(0, len(text)):
    for i in range(97, 123):
        if ord(text[x])==i or ord(text[x])==(i-32):
            letters[i-97]=letters[i-97]+1
            count=count+1
            break
    for i in range(224, 253):
        if ord(text[x])==i:
            letters[i-198]=letters[i-198]+1
            count=count+1
            break

#print results
for i in range(0, 26):
    print chr(i+97), ": ", letters[i]
for i in range(26, 55):
    print chr(i+198), ": ", letters[i]

#find frequency
for i in range(0, 55):
    letters[i]=float(letters[i])/float(count)
    
#Man Distance method
def findDist(a,n):
    ""
    dist=0
    language=lang[n]
    for i in range(1,56):
        dist=dist+abs(language[i]-a[i-1])
    print language[0]
    print dist
    return dist

#Find shortest Man Dist
finalDist = []
for i in range(0,15):
    finalDist.append(0)
    finalDist[i]=findDist(letters,i)
minDist = abs(finalDist[0])
minIndex = 0
for i in range(0,15):
    if abs(finalDist[i])<minDist:
        minDist=abs(finalDist[i])
        minIndex=i
final=lang[minIndex]
print "Language matches with: ", final[0]
