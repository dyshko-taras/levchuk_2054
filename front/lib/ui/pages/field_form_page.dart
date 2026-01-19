import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../constants/app_icons.dart';
import '../../constants/app_sizes.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_strings.dart';
import '../../data/local/database/app_database.dart';
import '../../providers/fields_provider.dart';
import '../../providers/settings_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/buttons/app_buttons.dart';
import '../widgets/inputs/app_text_fields.dart';

class FieldFormPage extends StatefulWidget {
  const FieldFormPage({super.key});

  @override
  State<FieldFormPage> createState() => _FieldFormPageState();
}

class _FieldFormPageState extends State<FieldFormPage> {
  final ImagePicker _imagePicker = ImagePicker();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lonController = TextEditingController();

  int? _editingFieldId;
  String? _type;
  String? _photoPath;

  bool _loading = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initFromState());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _notesController.dispose();
    _latController.dispose();
    _lonController.dispose();
    super.dispose();
  }

  void _initFromState() {
    final args = ModalRoute.of(context)?.settings.arguments;
    final requestedFieldId = args is FieldFormArgs ? args.fieldId : null;
    final createNew = args is FieldFormArgs ? args.createNew : false;

    if (createNew) {
      setState(() => _loading = false);
      return;
    }

    if (requestedFieldId == null) {
      setState(() => _loading = false);
      return;
    }

    final Field? field = context
        .read<FieldsProvider>()
        .fields
        .where((f) => f.id == requestedFieldId)
        .firstOrNull;

    if (field != null) {
      _editingFieldId = field.id;
      _nameController.text = field.name;
      _addressController.text = field.address ?? '';
      _notesController.text = field.notes ?? '';
      _type = field.type;
      _photoPath = field.photoPath;
      _latController.text = field.lat?.toString() ?? '';
      _lonController.text = field.lon?.toString() ?? '';
    }

    setState(() => _loading = false);
  }

  Future<void> _save() async {
    if (_saving) return;

    final name = _nameController.text.trim();
    final address = _addressController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.fieldFormNameRequiredError)),
      );
      return;
    }

    if (address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.fieldFormAddressRequiredError)),
      );
      return;
    }

    setState(() => _saving = true);

    final notes = _notesController.text.trim();
    final lat = double.tryParse(_latController.text.trim());
    final lon = double.tryParse(_lonController.text.trim());

    final provider = context.read<FieldsProvider>();
    if (_editingFieldId == null) {
      final id = await provider.createField(
        name: name,
        address: address,
        type: _type,
        notes: notes.isEmpty ? null : notes,
        lat: lat,
        lon: lon,
        photoPath: _photoPath,
      );
      final settings = context.read<SettingsProvider>();
      if (settings.defaultFieldId == null) {
        await settings.setDefaultFieldId(id);
      }
    } else {
      final Field? current = provider.fields
          .where((f) => f.id == _editingFieldId)
          .firstOrNull;
      if (current != null) {
        await provider.updateField(
          current.copyWith(
            name: name,
            address: Value(address),
            type: Value(_type),
            notes: Value(notes.isEmpty ? null : notes),
            lat: Value(lat),
            lon: Value(lon),
            photoPath: Value(_photoPath),
            updatedAt: Value(DateTime.now()),
          ),
        );
      }
    }

    if (!mounted) return;
    setState(() => _saving = false);
    Navigator.of(context).pop();
  }

  Future<void> _openMoreMenu() async {
    final fieldId = _editingFieldId;
    if (fieldId == null) return;

    final canDelete = await context.read<FieldsProvider>().canDeleteField(
      fieldId,
    );

    if (!mounted) return;
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.darkNavy,
      builder: (context) {
        return Padding(
          padding: Insets.allMd,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.whiteOverlay10,
              borderRadius: BorderRadius.circular(AppSpacing.lg),
              border: Border.all(color: AppColors.whiteOverlay20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(
                    AppStrings.commonDelete,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: canDelete
                          ? AppColors.darkRed
                          : AppColors.whiteOverlay70,
                    ),
                  ),
                  onTap: canDelete
                      ? () async {
                          Navigator.of(context).pop();
                          await context.read<FieldsProvider>().deleteFieldById(
                            fieldId,
                          );
                          if (!this.context.mounted) return;
                          Navigator.of(this.context).pop();
                        }
                      : () {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(this.context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                AppStrings.fieldFormDeleteNotAllowed,
                              ),
                            ),
                          );
                        },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _openPhotoMenu() async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.darkNavy,
      builder: (context) {
        return Padding(
          padding: Insets.allMd,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.whiteOverlay10,
              borderRadius: BorderRadius.circular(AppSpacing.lg),
              border: Border.all(color: AppColors.whiteOverlay20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(
                    AppStrings.fieldFormPhotoChooseFromGallery,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();
                    await _pickPhoto(ImageSource.gallery);
                  },
                ),
                const Divider(height: 1, color: AppColors.whiteOverlay20),
                ListTile(
                  title: Text(
                    AppStrings.fieldFormPhotoTakePhoto,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();
                    await _pickPhoto(ImageSource.camera);
                  },
                ),
                if (_photoPath != null) ...[
                  const Divider(height: 1, color: AppColors.whiteOverlay20),
                  ListTile(
                    title: Text(
                      AppStrings.fieldFormPhotoRemove,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.darkRed,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      setState(() => _photoPath = null);
                    },
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickPhoto(ImageSource source) async {
    final file = await _imagePicker.pickImage(source: source);
    if (file == null) return;
    if (!mounted) return;
    setState(() => _photoPath = file.path);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: ColoredBox(
          color: AppColors.darkNavy,
          child: SafeArea(child: SizedBox.shrink()),
        ),
      );
    }

    return Scaffold(
      body: ColoredBox(
        color: AppColors.darkNavy,
        child: SafeArea(
          child: Padding(
            padding: Insets.allMd,
            child: Column(
              children: [
                Row(
                  children: [
                    AppTopBarTextButton(
                      label: AppStrings.fieldsRegistryTitle,
                      onPressed: () => Navigator.of(context).maybePop(),
                      leading: SvgPicture.asset(
                        AppIcons.back,
                        width: AppSizes.iconMd,
                        height: AppSizes.iconMd,
                        colorFilter: const ColorFilter.mode(
                          AppColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    const Spacer(),
                    if (_editingFieldId != null)
                      AppIconCircleButton(
                        icon: SvgPicture.asset(
                          AppIcons.more,
                          width: AppSizes.iconMd,
                          height: AppSizes.iconMd,
                          colorFilter: const ColorFilter.mode(
                            AppColors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        onPressed: _openMoreMenu,
                      ),
                  ],
                ),
                Gaps.hMd,
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: Insets.allMd,
                      decoration: BoxDecoration(
                        color: AppColors.whiteOverlay10,
                        borderRadius: BorderRadius.circular(AppSpacing.lg),
                        border: Border.all(color: AppColors.whiteOverlay20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _RequiredLabel(
                            label: AppStrings.fieldFormNameLabel,
                          ),
                          Gaps.hSm,
                          AppPillTextField(
                            controller: _nameController,
                            hintText: AppStrings.fieldFormNameHint,
                          ),
                          Gaps.hMd,
                          const _RequiredLabel(
                            label: AppStrings.fieldFormAddressLabel,
                          ),
                          Gaps.hSm,
                          AppPillTextField(
                            controller: _addressController,
                            hintText: AppStrings.fieldFormAddressHint,
                          ),
                          Gaps.hMd,
                          Text(
                            AppStrings.fieldFormTypeLabel,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Gaps.hSm,
                          _TypeDropdown(
                            value: _type,
                            onChanged: (value) => setState(() => _type = value),
                          ),
                          Gaps.hMd,
                          Text(
                            AppStrings.fieldFormNotesLabel,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Gaps.hSm,
                          AppTextAreaField(
                            controller: _notesController,
                            hintText: AppStrings.fieldFormNotesHint,
                          ),
                          Gaps.hMd,
                          Row(
                            children: [
                              Expanded(
                                child: _LabeledPillField(
                                  label: AppStrings.fieldFormLatLabel,
                                  child: AppPillTextField(
                                    controller: _latController,
                                    hintText: AppStrings.fieldFormLatHint,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                          signed: true,
                                          decimal: true,
                                        ),
                                  ),
                                ),
                              ),
                              Gaps.wSm,
                              Expanded(
                                child: _LabeledPillField(
                                  label: AppStrings.fieldFormLonLabel,
                                  child: AppPillTextField(
                                    controller: _lonController,
                                    hintText: AppStrings.fieldFormLonHint,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                          signed: true,
                                          decimal: true,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gaps.hMd,
                          Text(
                            AppStrings.fieldFormPhotoLabel,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Gaps.hSm,
                          _PhotoPlaceholder(
                            path: _photoPath,
                            onPressed: _openPhotoMenu,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Gaps.hMd,
                AppPrimaryButton(
                  label: AppStrings.commonSave,
                  onPressed: _saving ? () {} : _save,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RequiredLabel extends StatelessWidget {
  const _RequiredLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.titleLarge,
        children: [
          TextSpan(text: label),
          const TextSpan(
            text: ' ${AppStrings.fieldFormRequiredMarker}',
            style: TextStyle(color: AppColors.darkRed),
          ),
        ],
      ),
    );
  }
}

class _LabeledPillField extends StatelessWidget {
  const _LabeledPillField({
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleMedium),
        Gaps.hXs,
        child,
      ],
    );
  }
}

class _TypeDropdown extends StatelessWidget {
  const _TypeDropdown({required this.value, required this.onChanged});

  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final options = const [
      AppStrings.fieldType5v5,
      AppStrings.fieldType7v7,
      AppStrings.fieldType11v11,
    ];

    return InputDecorator(
      decoration: InputDecoration(
        hintText: AppStrings.fieldFormTypeHint,
        hintStyle: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(color: AppColors.whiteOverlay70),
        filled: true,
        fillColor: AppColors.whiteOverlay10,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: const BorderSide(color: AppColors.whiteOverlay20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: const BorderSide(color: AppColors.whiteOverlay20),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(
            AppStrings.fieldFormTypeHint,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: AppColors.whiteOverlay70),
          ),
          items: [
            for (final option in options)
              DropdownMenuItem(
                value: option,
                child: Text(
                  option,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
          ],
          onChanged: onChanged,
          icon: SvgPicture.asset(
            AppIcons.chevronDown,
            width: AppSizes.iconMd,
            height: AppSizes.iconMd,
            colorFilter: const ColorFilter.mode(
              AppColors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}

class _PhotoPlaceholder extends StatelessWidget {
  const _PhotoPlaceholder({required this.path, required this.onPressed});

  final String? path;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizes.fieldFormPhotoSize,
      height: AppSizes.fieldFormPhotoSize,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.whiteOverlay10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.lg),
            side: const BorderSide(color: AppColors.whiteOverlay20),
          ),
          padding: EdgeInsets.zero,
        ),
        onPressed: onPressed,
        child: path == null
            ? SvgPicture.asset(
                AppIcons.add,
                width: AppSizes.iconMd,
                height: AppSizes.iconMd,
                colorFilter: const ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.lg),
                child: Stack(
                  children: [
                    Positioned.fill(child: _AnyImage(path: path!)),
                    const Positioned.fill(
                      child: ColoredBox(color: AppColors.whiteOverlay10),
                    ),
                    Center(
                      child: SvgPicture.asset(
                        AppIcons.edit,
                        width: AppSizes.iconMd,
                        height: AppSizes.iconMd,
                        colorFilter: const ColorFilter.mode(
                          AppColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class _AnyImage extends StatelessWidget {
  const _AnyImage({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) =>
            const ColoredBox(color: AppColors.whiteOverlay10),
      );
    }

    return Image.file(
      File(path),
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) =>
          const ColoredBox(color: AppColors.whiteOverlay10),
    );
  }
}

extension on Iterable<Field> {
  Field? get firstOrNull => isEmpty ? null : first;
}

class FieldFormArgs {
  const FieldFormArgs({this.fieldId, this.createNew = false});

  final int? fieldId;
  final bool createNew;
}
