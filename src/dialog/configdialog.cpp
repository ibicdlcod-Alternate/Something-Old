#include "configdialog.h"
#include "ui_configdialog.h"
#include "settings.h"

#ifdef AUDIO_SUPPORT
#ifdef  Q_OS_WIN32
    #include "irrKlang.h"
    extern irrklang::ISoundEngine *SoundEngine;
#else
    #include <phonon/AudioOutput>
    extern Phonon::AudioOutput *SoundOutput;
#endif
#endif

#include <QFileDialog>
#include <QDesktopServices>
#include <QFontDialog>
#include <QColorDialog>

ConfigDialog::ConfigDialog(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::ConfigDialog)
{
    ui->setupUi(this);

    // tab 1
    QString bg_path = Config.value("BackgroundBrush").toString();
    if(!bg_path.startsWith(":"))
        ui->bgPathLineEdit->setText(bg_path);

    ui->bgMusicPathLineEdit->setText(Config.value("BackgroundMusic").toString());

    ui->enableEffectCheckBox->setChecked(Config.EnableEffects);
    ui->enableLastWordCheckBox->setChecked(Config.EnableLastWord);
    ui->enableBgMusicCheckBox->setChecked(Config.EnableBgMusic);
    ui->fitInViewCheckBox->setChecked(Config.FitInView);
    ui->circularViewCheckBox->setChecked(Config.value("CircularView", false).toBool());
    ui->noIndicatorCheckBox->setChecked(Config.value("NoIndicator", false).toBool());
    ui->enableLogBgCheckBox->setChecked(Config.value("EnableLogBg", false).toBool());

    ui->volumeSlider_Effect->setValue(100 * Config.EffectVolume);
    ui->volumeSlider_Bgm->setValue(100 * Config.BGMVolume);
    if(Config.value("EffectEdition") == "classical/")
        ui->classicalRdo->setChecked(true);
    else if(Config.value("EffectEdition") == "professional1/")
        ui->professional1Rdo->setChecked(true);
    else if(Config.value("EffectEdition") == "professional2/")
        ui->professional2Rdo->setChecked(true);
    else
        ui->classicalRdo->setChecked(true);

    // tab 2
    ui->nullificationSpinBox->setValue(Config.NullificationCountDown);
    ui->neverNullifyMyTrickCheckBox->setChecked(Config.NeverNullifyMyTrick);

    connect(this, SIGNAL(accepted()), this, SLOT(saveConfig()));

    QFont font = Config.AppFont;
    showFont(ui->appFontLineEdit, font);

    font = Config.UIFont;
    showFont(ui->textEditFontLineEdit, font);

    QPalette palette;
    palette.setColor(QPalette::Text, Config.TextEditColor);
    ui->textEditFontLineEdit->setPalette(palette);

    // tab 3
    ui->smtpServerLineEdit->setText(Config.value("Contest/SMTPServer").toString());
    ui->senderLineEdit->setText(Config.value("Contest/Sender").toString());
    ui->passwordLineEdit->setText(Config.value("Contest/Password").toString());
    ui->receiverLineEdit->setText(Config.value("Contest/Receiver").toString());

    ui->onlySaveLordCheckBox->setChecked(Config.value("Contest/OnlySaveLordRecord", true).toBool());

    // 20111218 by Highlandz
    // tab 4 Custom Scene
    ui->enableCustomSceneCheckBox->setChecked(Config.value("EnableCustomScene", false).toBool());
    ui->autoShowDiscardsCheckBox->setChecked(Config.value("AutoShowDiscards", false).toBool());
    ui->photoPos1LineEdit->setText(Config.value("PhotoPos1").toString());
    ui->photoPos2LineEdit->setText(Config.value("PhotoPos2").toString());
    ui->photoPos3LineEdit->setText(Config.value("PhotoPos3").toString());
    ui->photoPos4LineEdit->setText(Config.value("PhotoPos4").toString());
    ui->photoPos5LineEdit->setText(Config.value("PhotoPos5").toString());
    ui->discardedAreaLineEdit->setText(Config.value("DiscardedArea").toString());
    ui->discardedPosLineEdit->setText(Config.value("DiscardedPos").toString());
    ui->drawPilePosLineEdit->setText(Config.value("DrawPilePos").toString());
    ui->stateItemLineEdit->setText(Config.value("StateItem").toString());
    ui->chatBoxLineEdit->setText(Config.value("ChatBox").toString());
    ui->logBoxLineEdit->setText(Config.value("LogBox").toString());
    ui->indicatorDurationLineEdit->setText(Config.value("IndicatorDuration").toString());
    ui->indicatorWidthLineEdit->setText(Config.value("IndicatorWidth").toString());
}

void ConfigDialog::showFont(QLineEdit *lineedit, const QFont &font){
    lineedit->setFont(font);
    lineedit->setText(QString("%1 %2").arg(font.family()).arg(font.pointSize()));
}

ConfigDialog::~ConfigDialog()
{
    delete ui;
}

void ConfigDialog::on_browseBgButton_clicked()
{
    QString location = QDesktopServices::storageLocation(QDesktopServices::PicturesLocation);
    QString filename = QFileDialog::getOpenFileName(this,
                                                    tr("Select a background image"),
                                                    location,
                                                    tr("Images (*.png *.bmp *.jpg)"));

    if(!filename.isEmpty()){
        ui->bgPathLineEdit->setText(filename);

        Config.BackgroundBrush = filename;
        Config.setValue("BackgroundBrush", filename);

        emit bg_changed();
    }
}

void ConfigDialog::on_resetBgButton_clicked()
{
    QString default_bg = "backdrop/sgs.jpg";
    Config.BackgroundBrush = default_bg;
    Config.setValue("BackgroundBrush", default_bg);
    ui->bgPathLineEdit->setText(default_bg);
    emit bg_changed();
}

void ConfigDialog::saveConfig()
{
    int count_down = ui->nullificationSpinBox->value();
    Config.NullificationCountDown = count_down;
    Config.setValue("NullificationCountDown", count_down);

    float EffectVol = ui->volumeSlider_Effect->value() / 100.0;
    Config.EffectVolume = EffectVol;
    Config.setValue("EffectVolume", EffectVol);

    float BgmVol = ui->volumeSlider_Bgm->value() / 100.0;
    Config.BGMVolume = BgmVol;
    Config.setValue("BGMVolume", BgmVol);

    if(ui->classicalRdo->isChecked())
        Config.setValue("EffectEdition", "classical/");
    else if(ui->professional1Rdo->isChecked())
        Config.setValue("EffectEdition", "professional1/");
    else if(ui->professional2Rdo->isChecked())
        Config.setValue("EffectEdition", "professional2/");

#ifdef AUDIO_SUPPORT
#ifdef  Q_OS_WIN32
    if(SoundEngine)
        SoundEngine->setSoundVolume(Config.EffectVolume);
#else
    if(SoundOutput)
        SoundOutput->setVolume(Config.EffectVolume);
#endif
#endif

    bool enabled = ui->enableEffectCheckBox->isChecked();
    Config.EnableEffects = enabled;
    Config.setValue("EnableEffects", enabled);

    enabled = ui->enableLastWordCheckBox->isChecked();
    Config.EnableLastWord = enabled;
    Config.setValue("EnabledLastWord", enabled);

    enabled = ui->enableBgMusicCheckBox->isChecked();
    Config.EnableBgMusic = enabled;
    Config.setValue("EnableBgMusic", enabled);

    Config.FitInView = ui->fitInViewCheckBox->isChecked();
    Config.setValue("FitInView", Config.FitInView);

    Config.setValue("CircularView", ui->circularViewCheckBox->isChecked());

    Config.setValue("NoIndicator", ui->noIndicatorCheckBox->isChecked());

    Config.setValue("EnableLogBg", ui->enableLogBgCheckBox->isChecked());

    Config.NeverNullifyMyTrick = ui->neverNullifyMyTrickCheckBox->isChecked();
    Config.setValue("NeverNullifyMyTrick", Config.NeverNullifyMyTrick);

    Config.setValue("Contest/SMTPServer", ui->smtpServerLineEdit->text());
    Config.setValue("Contest/Sender", ui->senderLineEdit->text());
    Config.setValue("Contest/Password", ui->passwordLineEdit->text());
    Config.setValue("Contest/Receiver", ui->receiverLineEdit->text());
    Config.setValue("Contest/OnlySaveLordRecord", ui->onlySaveLordCheckBox->isChecked());

    // 20111218 by Highlandz
    // tab 4 Custom Scene
    Config.setValue("EnableCustomScene",ui->enableCustomSceneCheckBox->isChecked());
    Config.setValue("AutoShowDiscards",ui->autoShowDiscardsCheckBox->isChecked());
    Config.setValue("PhotoPos1",ui->photoPos1LineEdit->text());
    Config.setValue("PhotoPos2",ui->photoPos2LineEdit->text());
    Config.setValue("PhotoPos3",ui->photoPos3LineEdit->text());
    Config.setValue("PhotoPos4",ui->photoPos4LineEdit->text());
    Config.setValue("PhotoPos5",ui->photoPos5LineEdit->text());
    Config.setValue("DiscardedArea",ui->discardedAreaLineEdit->text());
    Config.setValue("DiscardedPos",ui->discardedPosLineEdit->text());
    Config.setValue("DrawPilePos",ui->drawPilePosLineEdit->text());
    Config.setValue("StateItem",ui->stateItemLineEdit->text());
    Config.setValue("ChatBox",ui->chatBoxLineEdit->text());
    Config.setValue("LogBox",ui->logBoxLineEdit->text());
    Config.setValue("IndicatorDuration",ui->indicatorDurationLineEdit->text());
    Config.setValue("IndicatorWidth",ui->indicatorWidthLineEdit->text());
}

void ConfigDialog::on_browseBgMusicButton_clicked()
{
    QString location = QDesktopServices::storageLocation(QDesktopServices::MusicLocation);
    QString filename = QFileDialog::getOpenFileName(this,
                                                    tr("Select a background music"),
                                                    location,
                                                    tr("Audio files (*.wav *.mp3)"));
    if(!filename.isEmpty()){
        ui->bgMusicPathLineEdit->setText(filename);
        Config.setValue("BackgroundMusic", filename);
    }
}

void ConfigDialog::on_resetBgMusicButton_clicked()
{
    QString default_music = "audio/system/background.mp3";
    Config.setValue("BackgroundMusic", default_music);
    ui->bgMusicPathLineEdit->setText(default_music);
}

void ConfigDialog::on_changeAppFontButton_clicked()
{
    bool ok;
    QFont font = QFontDialog::getFont(&ok, Config.AppFont, this);
    if(ok){
        Config.AppFont = font;
        showFont(ui->appFontLineEdit, font);

        Config.setValue("AppFont", font);
        QApplication::setFont(font);
    }
}


void ConfigDialog::on_setTextEditFontButton_clicked()
{
    bool ok;
    QFont font = QFontDialog::getFont(&ok, Config.UIFont, this);
    if(ok){
        Config.UIFont = font;
        showFont(ui->textEditFontLineEdit, font);

        Config.setValue("UIFont", font);
        QApplication::setFont(font, "QTextEdit");
    }
}

void ConfigDialog::on_setTextEditColorButton_clicked()
{
    QColor color = QColorDialog::getColor(Config.TextEditColor, this);
    if(color.isValid()){
        Config.TextEditColor = color;
        Config.setValue("TextEditColor", color);
        QPalette palette;
        palette.setColor(QPalette::Text, color);
        ui->textEditFontLineEdit->setPalette(palette);
    }
}

void ConfigDialog::on_cv1024x768Button_clicked()
{
    ui->photoPos1LineEdit->setText("0,-10");
    ui->photoPos2LineEdit->setText("45,-10");
    ui->photoPos3LineEdit->setText("0,0");
    ui->photoPos4LineEdit->setText("80,-10");
    ui->photoPos5LineEdit->setText("80,-10");
    ui->discardedAreaLineEdit->setText("140,460,6");
    ui->discardedPosLineEdit->setText("0,-15");
    ui->drawPilePosLineEdit->setText("0,-15");
    ui->stateItemLineEdit->setText("-130,-5");
    ui->chatBoxLineEdit->setText("-130,-5,0,0");
    ui->logBoxLineEdit->setText("-130,-5,0,0");
    ui->circularViewCheckBox->setChecked(true);
    ui->enableCustomSceneCheckBox->setChecked(true);
}

void ConfigDialog::on_nv1024x768Button_clicked()
{
    ui->photoPos1LineEdit->setText("0,-45");
    ui->photoPos2LineEdit->setText("0,-45");
    ui->photoPos3LineEdit->setText("0,-45");
    ui->photoPos4LineEdit->setText("0,-45");
    ui->photoPos5LineEdit->setText("0,0");
    ui->discardedAreaLineEdit->setText("135,620,8");
    ui->discardedPosLineEdit->setText("160,-75");
    ui->drawPilePosLineEdit->setText("-160,-75");
    ui->stateItemLineEdit->setText("0,-25");
    ui->chatBoxLineEdit->setText("-10,-35,-200,60");
    ui->logBoxLineEdit->setText("210,-35,0,60");
    ui->circularViewCheckBox->setChecked(false);
    ui->enableCustomSceneCheckBox->setChecked(true);
}

void ConfigDialog::on_cv1366x768Button_clicked()
{
    ui->photoPos1LineEdit->setText("0,-15");
    ui->photoPos2LineEdit->setText("0,-15");
    ui->photoPos3LineEdit->setText("0,0");
    ui->photoPos4LineEdit->setText("0,-15");
    ui->photoPos5LineEdit->setText("-85,5");
    ui->discardedAreaLineEdit->setText("140,760,10");
    ui->discardedPosLineEdit->setText("0,-25");
    ui->drawPilePosLineEdit->setText("0,-25");
    ui->stateItemLineEdit->setText("40,-5");
    ui->chatBoxLineEdit->setText("40,-5,0,0");
    ui->logBoxLineEdit->setText("40,-5,0,0");
    ui->circularViewCheckBox->setChecked(true);
    ui->enableCustomSceneCheckBox->setChecked(true);
}

void ConfigDialog::on_nv1366x768Button_clicked()
{
    ui->photoPos1LineEdit->setText("0,-45");
    ui->photoPos2LineEdit->setText("0,-45");
    ui->photoPos3LineEdit->setText("0,-45");
    ui->photoPos4LineEdit->setText("0,-45");
    ui->photoPos5LineEdit->setText("0,0");
    ui->discardedAreaLineEdit->setText("135,1000,12");
    ui->discardedPosLineEdit->setText("160,-75");
    ui->drawPilePosLineEdit->setText("-160,-75");
    ui->stateItemLineEdit->setText("0,-25");
    ui->chatBoxLineEdit->setText("-180,-255,-220,480");
    ui->logBoxLineEdit->setText("400,-255,0,480");
    ui->circularViewCheckBox->setChecked(false);
    ui->enableCustomSceneCheckBox->setChecked(true);
}
