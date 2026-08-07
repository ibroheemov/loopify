import 'package:betterloop/models/icon_meta.dart';
import 'package:flutter/material.dart';

class EffeciencyIcons {
  EffeciencyIcons._();

  static const String _kFontFam = 'EfficiencyIcons';

  static const IconData trashSvgrepoCom =
      IconData(0xe900, fontFamily: _kFontFam);
  static const IconData statisticsSvgrepoCom =
      IconData(0xe901, fontFamily: _kFontFam);
  static const IconData bookBookmarkMinimalisticSvgrepoComEdit =
      IconData(0xe902, fontFamily: _kFontFam);
  static const IconData truckFastSvgrepoCom =
      IconData(0xe903, fontFamily: _kFontFam);
  static const IconData tshirtTShirtRecycle =
      IconData(0xe904, fontFamily: _kFontFam);
  static const IconData bookBookmarkSvgrepoCom =
      IconData(0xe905, fontFamily: _kFontFam);
  static const IconData calendarEditSvgrepoCom =
      IconData(0xe906, fontFamily: _kFontFam);
  static const IconData calendarTimeNearDeadline =
      IconData(0xe907, fontFamily: _kFontFam);
  static const IconData calendarTimeOneThird =
      IconData(0xe908, fontFamily: _kFontFam);
  static const IconData conversation = IconData(0xe909, fontFamily: _kFontFam);
  static const IconData documentDeadlineTime =
      IconData(0xe90a, fontFamily: _kFontFam);
  static const IconData envelopeOnTime =
      IconData(0xe90b, fontFamily: _kFontFam);
  static const IconData folderOpenSvgrepoCom =
      IconData(0xe90c, fontFamily: _kFontFam);
  static const IconData notebookOfContactsSvgrepoCom =
      IconData(0xe90d, fontFamily: _kFontFam);
  static const IconData shoppingCartList =
      IconData(0xe90e, fontFamily: _kFontFam);
  static const IconData tasksCog = IconData(0xe90f, fontFamily: _kFontFam);
  static const IconData answerStudentSvgrepoCom =
      IconData(0xe911, fontFamily: _kFontFam);

  static final List<IconMeta> iconMetaList = [
    IconMeta(trashSvgrepoCom, 'trash_svgrepo_com',
        ['delete', 'waste', 'clean', 'remove', 'efficiency']),
    IconMeta(statisticsSvgrepoCom, 'statistics_svgrepo_com',
        ['data', 'chart', 'performance', 'metrics', 'analytics']),
    IconMeta(
        bookBookmarkMinimalisticSvgrepoComEdit,
        'book_bookmark_minimalistic_svgrepo_com_edit',
        ['book', 'reading', 'study', 'notes', 'edit']),
    IconMeta(truckFastSvgrepoCom, 'truck_fast_svgrepo_com',
        ['delivery', 'truck', 'fast', 'shipping', 'logistics']),
    IconMeta(tshirtTShirtRecycle, 'tshirt_t_shirt_recycle',
        ['recycle', 'clothing', 'tshirt', 'eco', 'reuse']),
    IconMeta(bookBookmarkSvgrepoCom, 'book_bookmark_svgrepo_com',
        ['book', 'bookmark', 'reading', 'study']),
    IconMeta(calendarEditSvgrepoCom, 'calendar_edit_svgrepo_com',
        ['calendar', 'schedule', 'edit', 'plan', 'organize']),
    IconMeta(calendarTimeNearDeadline, 'calendar_time_near_deadline',
        ['deadline', 'calendar', 'time', 'urgent', 'reminder']),
    IconMeta(calendarTimeOneThird, 'calendar_time_one_third',
        ['calendar', 'progress', 'time', 'schedule']),
    IconMeta(conversation, 'conversation',
        ['chat', 'talk', 'discussion', 'communication']),
    IconMeta(documentDeadlineTime, 'document_deadline_time',
        ['document', 'deadline', 'submission', 'paperwork', 'urgency']),
    IconMeta(envelopeOnTime, 'envelope_on_time',
        ['email', 'on time', 'message', 'communication']),
    IconMeta(folderOpenSvgrepoCom, 'folder_open_svgrepo_com',
        ['folder', 'files', 'documents', 'organize']),
    IconMeta(notebookOfContactsSvgrepoCom, 'notebook_of_contacts_svgrepo_com',
        ['contacts', 'notebook', 'people', 'address book']),
    IconMeta(shoppingCartList, 'shopping_cart_list',
        ['shopping', 'cart', 'list', 'groceries', 'plan']),
    IconMeta(tasksCog, 'tasks_cog',
        ['tasks', 'settings', 'automation', 'optimize', 'management']),
    IconMeta(answerStudentSvgrepoCom, 'answer_student_svgrepo_com',
        ['student', 'answer', 'quiz', 'learning', 'test']),
  ];
}
