# أعمال
Created السبت 16 أغسطس 2014

### بناء صوت عربي مغتوح المصدر
جربت سابق العمل على برنامج espeak وقد توصلنا فيه إلى نتائج مشجعة.
عملنا على إسبيك كان مشجعا على الرغم من رداءة الصوت الناتج مقارنة بالنظم التجارية، قد تلقينا طلبات وتشجيعات من إخواننا المكفوفين الراغبين في الحصول على صوت عربي مفتوح المصدر، وتخفيض تكلفة استعماله.
لكن طبيعة إسبيك أنّ صوته آلي، لا فكرنا أن نعمل على برنامج أقوى وهو فيستيفال festival الذي يعتمد على تخليق الصوت من ثنائيات الصوت diphones أو مقاطع.
مثلا بَ => ديفون مكون من فونيمين هما الباء والفتحة
ويتم تسجيل الصوت البشرين مما يجعل النتائج تكون أفضل عند تركيبها.
نظام فيتسفال مفتوح المصدر يدعم بناء أصوات لهذا النظام وهو مستعمل على لينكس كما وندوز.
يقدّم نظام فيتسفال بيئة مدمجة ويستعمل لغة البرمجة  سكيم [Scheme](#المنطيق:Scheme) لبرمجة الاصوات والتحكم بها دون تعديل النظام الاساسي.

تطوير الصوت في هذا النظام صعب وشاق، لذا ظهر مشروع festvox لتسهيل عملية التطوير وتقيدم وثائق مفصلة عن كل مرحلة.

قواعد بيانات صوتية
------------------

* ربما هذه جاهزة أكثر للعمل عليها

<http://www.festvox.org/cmu_wilderness/index.html>
هذه فيها أصوات عربية من الإنجيل


* المدونة الصوتية العربية


#### هل من صوت عربي يعمل على فيستيفال
أجل، ~~انتقلت شركة غوغل من العمل على أسبيك إلى festvox  في جميع أصواتها المستعملة في خدمة الترجمة، (أذكر أنني قرات ذلك في صفحة على وكيبيدا لكنني لم أعثر عليها مجددا)~~

* شركة غوغل تستعمل svox  تجارية.
* صنعت الباحثة Moutran  صوتا عربية تجريبيا في مذكرة الماسترن وتحدثت عن تفاصيل الموضوع في المذكرة الموجودة على النت، وقدّمت معلومات مهمة عن الموضوع ، لكنني حاولت الاتصال بها والحصول بها والحصول على بيانات الصوت، فلم افلح.


### تطوير صوت عربي
فعلا برنامج فيستفال موثق جيدا لكن كثرة الوثائق تصيب بالارتباك مما يجعلك لا تدري من أين تبدأ.
للعلم فتوثيق festvox يأتي مزوّدا بالعديد من القوالب التي تسهل عملية البناء.
وأهم وثيقة حصلت عليها تبين هذه المراحل باختصار وحسب الأوامر المطلوبة
creating a voice for festival speech sythesis system, mathew Hood, Rhodes University, 2004
هذه الوثيقة موجودة في توثيق festox في قسم الأمثلة.
يقدّم هذا المستند وثيقة جيدة في ترتيب `إنشاء صوت جديد باستعمال أدوات festvox.
المستند يتحدث عن إنشاء صوت إنجليزي جديد، لكنه لا يتحدث عن إنشاء صوت للغة جديدة.
أعتقد أنّ الأمر يتطلب أشياء كثيرة.

##### مشكلة مفتوحة
كيفية بناء جدول تحويل LTS Rules به حروف عربية أو يونيكود

في الفصل الخامس من وثيفة ماثيو يتحدث عن بناء صوت جديد في مراحل:

* إنشاء القوالب
* توليد المستدعيات
* تسجيل المقاطع الصوتية
* وسم الكلمات المسجلة آليا
* توليد فهرس المقاطع الثنائية diphone
* توليد علامات الحدة pitchmarks ومعاملا LPC


تجربة الحزمة
------------
قبل البدء تحقق أن لديك الأدوات الآتية:

* لينكس: النظام الذي يعمل عليه SPEECH TOOLS (يستحسن تجميعها من المصدر ﻷنّ حزم التثبيت لنظم التوزيعات ناقصة)
* برنامح FESTIVAL ويمكن تثبيته من إدارة الحزم.
* حزمة festvox يستحسن تجميعها من المصدر
* برنامج emulabel (لم أتمكن من الحصول عليه، لأنّ الإصدارات الأحدث لا تقدّ بعض الأدوات منفردة مثلما نحتاج إليه في هذا الدليل).



ماذا تفعل قبل البدء:
عليك تعديل متغيرات البيئة 
	ESTDIR 
	FESTVOXDIR

وتوجيهها إلى المجلدات المناسبة،
يستحسن إضافة هذه المتغيرات إلى ملف إعدادات الدخول .bach_profile
تحقق أنّ برنامج فيستيفال يعمل لاسيما إن بنيته من المصدر
للتحقق نفّذ الأمر
``$ festival``
إذا لم يكن موجودا أضفه إلى مسار البحث عن البرامج التنفيذية $PATH

#### ملاحظة
(الخطوات الموالية مأخوة من وثيقة ماثيو مع إضافة تعليقات عربية وتجربتي الخاصة عليها)

الخطوات
-------
1- أنشئ مجلدا 
mkdir net-ar-abdo-diphone
يتكون اسم المجلد أو الصوت من عدة أجزاء
INST-LANG-VOICE-TYPE
القسم INST اسم الهيئة أو المؤسسة، إذا لم تكن تابعا لمؤسسة أو هيئة، استعمل كلمة شبكة NET
القسم lang اختصار اللغة
القسم VOICE اسم المتكلم وهنا اسميناه عبده
القسم Type  نوع الصوت، وقد اخترنا الصوت مركبا من ثنائيات diphone

خطوة2- تجهيز القوالب
--------------------

2- نفذ الامر الآتي لتوليد ملفات القوالب داخل المجلد المذكور 
FESTVOXDIR/src/diphones/setup-diphone net ar abdo
--------------

تنبيه:
في وثيقة ماثيو ورد خطأ وهو 
setup-diphone_ru_us_matt
والصواب:
setup-diphone ru us matt
أو انه أراد تثبيت الفراغات فقط لرفع الالتباس
-------

ألق نظرة على محتويات المجلد net-ar-abdo-diphone
تجد أنّ festvox أضاف عددا من الملفات والقوالب والبرامج (رقع برمجية)
نتعرف على بعض منها

* bin : ملفات تنفيذية نستعملها لاحقا 
* etc : ملفات الإعدادات سنعدّلها لإعداد ملفنا الصوتي
* recording: لوضع الملفات الصوتية المسجلة




خطوة 3- توليد قائمة المقاطع المطلوبة لتسجيلها:
----------------------------------------------

دائما داخل المجلد، نفّذ الأمر 
festival -b FestVox/diphlist.scm FestVox/ar_schema.scm  '(diphone-gen-schema ar etc/ardiph.list)'
( لاحظ أنّ ar هو للعربية ، في وثيقة ماثيو لدينا us).

شرح هذه الخطوة:
1- ملف الإدخال هو FestVox/ar_schema.scm
2- ملف الإخراج هو etc/ardiph.list
جرّب تنفيذ الأمر وألق نظرة على النتيجة etc/ardiph.list

ملف etc/ardiph.list الناتج بلغة سكيم، فيه قائمة الأصوات التي ينبغي تسجيلها
(ar_0001 pau t aa b aa b aa pau (b-aa aa-b)) 
(ar_0002 pau t aa p aa p aa pau (p-aa aa-p)) 
..^File ID...^pok en prompt...... ^ name of diphones being recorded
الصيغة فيها اسم ملف الصوت دون لاحقة، تهجئة المقطع، ووالمقطع المحدد
العلامة pau تعني وقف أو سكتة

**تعديل ملف الإدخال ar_schema**
**تنبية: **سنعمل على صوت بدائي مبسط به عدد محدود من الأصوات، حتى نتمكن من إنجاز المهمة ومن ثم توسيعها، 
سنقتصر على 

* حرفين صامتين وليكونا b,s ;
* و حرفين صائتين هما a, u


في الملف 
42: (set! vowels '(a u))
43: (set! consonant '(b s))
44: (set! no cvcs  '(b s))
ننتقل إلى الدالة diphone-get-list
383: (define (diphone-get-list)
التي تحدد قائمة المقاطع التي ستولّد
(list-vcs) ; vowel consonante 
(list-cvs) ;  consonante  vowel
(list-silv) ; silent vowel
(list-silc) ; silent consonante 
(list-vsil) ;  vowel silent
(list-csil) ;  consonante  silent
نستغني عن 
(list-cvcs) ; consonante vowel consonante 
(list-vvs) ;  vowel  vowel
بأن نعلقها بوضع النقطة الفاصلة  (;) علامة التعليق
وتفريغ بعض المجموعات لاغراض تجريبية تتعلق باقتصار صوتنا الجديد المبسط، أما في صوت عادي فعلينا تحديد هذه المجموعات
onset-only
coda-only
stops
nasals
liquids

بعد ذلك نطبق الامر السابق

festival -b festvox/diphlist.scm festvox/ar_schema.scm '(diphone-gen-schema "ar" "etc/ardiph.list")'
لتوليد قائمة الأصوات التي علينا تسجيلها
لنحصل على 21 مدخلا في ملف etc/ardiph.list 
منها أربعة متعلقة ب prompts  وهي خدمة تسميع مبدئي للصوت لتسهيل تسجيله.


خطوة 4- مرحلة النداء
--------------------

يحاول فيستيفال أن يقرا المقاطع التي تريدها بأحد الاصوات التي لديه ليسهل عليك تسجيلها،
الصوت الذي سيستعمله للقراءة معرف في الملف festvox/ar_schema.scm   في السطر 
325: (voice_bal_diphone)
عند التنفيذ، إذا لم يتمكن الأمر من التعرف على (voice_bal_diphone) فالصوت غير مثبت عندك.
يمكنك اختيار صوت آخر
لمعرفة الأصوات المثبتة أدخل الأمر
festival 
>(voice.list)
يعطيك
(kal_diphone en1_mbrola us1_mbrola don_diphone)

عليك تثبيت هذه الأصوات من مدير التطبيقات أو بسطر الأوامر 
~~مشكلة لم تنجح هذه المرحلة~~ 
~~مشكلة في~~ 
تعديل السطر رقم 328
 ``"(Diphone_Prompt_Setup)``
``Called before synthesizing the prompt waveforms.  Uses the KAL speakers``
``(the most standard US voice)."``
``;(voice_nitech_us_slt_arctic_hts)``
``(voice_kal_diphone)  ;; US male voice``
عليك تثبيت الصوت المناسب، هنا ثبتنا عدة أصوات.
نحتاج إلى تطابق بين الفونيمات وفونيمات الصوت الأجنبي kal_diphone كي نتمكن من تسميع النداء
الأمر رقم 4/ تصحيح ما جاء في مذكرة ماثيو وتخصيصه للعربية.

	festival -b festvox/diphlist.scm festvox/ar_schema.scm \
	'(diphone-gen-waves "prompt-wav" "prompt-lab" "etc/ardiph.list")'

* مشكلة:

ظهرت المشكلة الآتية:
(ar_0001 "pau t aa b a b aa pau" ("b-a" "a-b"))
Phone "a" not member of PhoneSet "radio"
Phone a not in PhoneSet "radio"
بحثت عن الحل، وجدته في الرابط الآتي:
<https://festvox-talk.festvox.narkive.com/qn9wShzu/my-phones-not-members-of-phoneset-radio>
فذهبت إلى المجلد 
[festvox/src/diphones/ja_schema.scm]()
وقمت بنسخ الدالتان 
(set! nhg2radio_map
  '((a aa)
(u uw)
))
وتقليل عددة الحروف إلى ما أحتاج إليه فقط
ثم نسخت الدالة (define (Diphone_Prompt_Word utt) كما هي
في ملف festvox/ar_schema.scm
في آخر الملف ، لكن تركت السطر الأخير كما هو.
نجحت هذه المرة -07-08-2019

الخطوة 5
--------
5- استدعاء الملفات لتسهيل التسجيل
``bin/prompt_them etc/ardiph.list``
نجحت، وأنتجت ملفات في المجلد Prompt_wav

الخطوة السادسة
--------------
بعد تسجيل كل الثنائيات، ننتقل إلى الوسم الآلي autolabel
bin/make_labs prompt-wav/*.wav
مشكلة segmentation fault، لكنها أنتجت ملفات في prompt_lab

#### 6.1 مشكلة

* عند مهمة التوسيم Labeling
* bin/make_labs wav/*.wav


تجد أنّ الملف يطلب وجود ملف يسمى txt.done.data
وجدت في أحد المنتديات أنه يمكن استبدال الأمر ب:
bin/make_labs etc/ardiph.list
حيث ardiph.list هو ملف فيه أسماء ملفات الأصوات المرفقة بكل مقطع صوتي، الملف مكتوب بلغة سكيم.
*** في هذه المرة، لم أضطر إلى التعديلات الواردة في6.1

### خطوة 7
التصحيح اليدوي للوسوم
emulabel etc/emu_lab

#### 7.1 برنامج EMULabel
ورد في منتدى الدعم الفني لبرنامج Emu speech database أن هذه الأدوات ومنها أداة emulabel لم تعد تأتي منفردة، كما أنّ البرنامج لم يعد يدعم معالجة الملفات المنفردة.
قال أحدهم أنّ برنامج wavesurfer المدمج بنظام emu يمكن أن يعمل على وسم الاصوات labeling بعد وضع كل الملفات lab/*.lab و wav/*.wav  مع بعض في مجلد واحد.

* حزمة Edenburg  speech tech التي تأتي محزومة في festival-speeck tools ناقصة، وجدت أنها تنقص ملفا تنفيذيا يسمى sigfilter نحتاج إليه في مرحلة استخلاص علامات الحدة pitchmark، مما اضطرني إلى إعادة تصريفه compiling م[ن](#المنطيق:ن) المصدر speech tools 2.1.
* في المصدر بعض الأخطاء يمكن ضبطها يدويا في المصدر.
* 1- أخطاء تتعلق بنطاق  namespace بعض الدوال، ينبغي أن لا تستدعى مباشرة مثل 

begin()
value()
this->begin()
this->value()
المصرّف يقترح عليك ذلك، وهذا ينجح.
2# أخطاء أخرى تتعلق بإعادة إعلان memcpy و memset ويمكن تلافي هذه الأخطاء بإضافة الإعلان التالي في الملفين المعنيين بالخطأ
#include "string.h"


الخطوة 8
--------
بناء فهرس المقاطع الثنائية

bin/make_diph_index etc/ardiph.list dic/nwrdiph.est
اسم nwr هو اسم صاحب الصوت المحتمل
مشكلة: لا يوجد مجلد voices ولا dicts في مجلد تطوير festival
لذا نسختهم من المجلد الأصلي
cd /usr/share/festival
cp -r voices ~/projects/festival-project/festival/lib/
cp -r dicts/ [~/projects/festival-project/festival/lib/](file:///home/zerrouki/projects/festival-project/festival/lib)
ثم أنشأت المجلد dic في مجلد العمل.
مشكلة: 
Cannot open file lab//ar_0001.lab as tokenstream
load_relation: can't open relation input file lab//ar_0001.lab
utt.load.relation: loading from "lab//ar_0001.lab" failed
حل: 
 cp prompt-lab/* lab/

الخطوة 9: استخلاص علامات الحدة pitchmark
----------------------------------------

bin/make_pm_wave wav/*.wav
هذه الخطوة تتطلب ملف etc/txt.data.done
وجدت شكله في حزمة اللغة الهندية على الشكل
( bn_00001 "অষ্টাদশ শতাব্দীর পূর্বে, বাংলা ব্যাকরণ রচনার কোন উদ্যোগ নেওয়া হয়নি।" )
( bn_00003 "ঐ বছর তিনি চট্টগ্রাম কলেজে এফ. এ. পড়ার জন্য ভর্তি হন।" )
لذا صعنت الملف كالآتي
( ar_0001 "ba ab" )
( ar_0002 "sa as" )
( ar_0003 "bu ub" )
الملف يجرد الملفات الموجودة في المدونة الصوتية وما يقابلها من نص.
وحسب ملاحظة في أحد المنتديات يمكن استبداله بالأمر
bin/make_pm_wave etc/ardiph.list 
نجح الأمر
ثم 
bin/make_pm_fix pm/*.pm
استبدلته بالأمر
bin/make_pm_fix  etc/ardiph.list 

الخطوة 10 إيجاد العوامل القوية
------------------------------

10. You can optionally match the power, first the files must be analysed and a mean factor extracted

bin/find_powerfactors lab/*.lab
لم تنجح أعطت قسمة على صفر

And finally you can use this to build the pitch-synchronous LPC coefficients
bin/make_lpc wav/*.wav

يمكن استعمال  بدلا عنها قائمة etc/ardiph.list لأن الملف يحتاج إلى etc/txt.data.done
bin/make_lpc etc/ardiph.list

الخطوة 11 تجربة الصوت
---------------------
قاعدة البيانات جاهزة للتجربة
``festival festvox/net_ar_nwr_diphone.scm '(voice_net_ar_nwr_diphone)``'
مشكلة
	SIOD ERROR: You have not yet defined a phoneset for ar (and others things ?)
	            Define it in festvox/net_ar_nwr_phoneset.scm


### ملء  البيانات الأساشية
1- تعريف phoneset في الملف festvox/net_ar_nwr_phoneset.scm
نسخت أجزاء من الكود من ملف [~/workspace/projects/festival-project/festival/lib/cmusphinx2_phones.scm](file:///home/zerrouki/workspace/projects/festival-project/festival/lib/cmusphinx2_phones.scm) 
ووضعتها في الملف المطلوب،
ثم عليك تعليق رسالة الخطأ في السطر 43
``;(error "You have not yet defined a phoneset for ar (and others things ?)\n            Define it in festvox/net_ar_nwr_phoneset.scm\n")``
2- تعريف tagger
مطلوب ملف festvox/net_ar_nwr_gpos.scm
نسخت الملف festival/lib/pos.scm



