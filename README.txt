SMAAIL STORE — متجر حقيقي (المرحلة الجاهزة للربط)

المشروع فيه:
- index.html: المتجر للزبائن.
- admin.html: لوحة التحكم من الهاتف.
- products: منتجات حقيقية في قاعدة البيانات.
- orders: الطلبات محفوظة في قاعدة البيانات.
- دخول الإدارة بالبريد وكلمة السر.
- الدفع عند الاستلام.
- التوصيل لجميع المغرب.
- إرسال الطلب أيضاً إلى WhatsApp +212 689 834 844.
- العربية / Français.
- روابط Instagram/Facebook/TikTok حالياً placeholders حتى تزيدهم من بعد.

الربط مع Supabase:
1) أنشئ مشروع Supabase.
2) افتح SQL Editor والصق schema.sql ونفّذه.
3) أنشئ مستخدم Admin من Authentication > Users (email + password).
4) خذ User ID ديال المستخدم ونفّذ:
   insert into public.admin_users(user_id) values ('ضع-USER-ID-هنا');
5) من Project Settings/API خذ Project URL و Publishable key.
6) افتح config.js وحطهم مكان القيم التجريبية.
7) ارفع الملفات على أي استضافة static.
8) المتجر: /index.html
9) الإدارة: /admin.html

مهم: استعمل Publishable/anon key فقط في الواجهة، وما تحطش service_role/secret key في ملفات الموقع.

