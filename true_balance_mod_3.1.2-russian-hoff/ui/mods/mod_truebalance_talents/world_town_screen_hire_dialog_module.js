var TrueBalance = {
    ID : "mod_true_balance"
}

TrueBalance.WorldTownScreenHireDialogModule_createDIV = WorldTownScreenHireDialogModule.prototype.createDIV
WorldTownScreenHireDialogModule.prototype.createDIV = function (_parentDiv)
{
    TrueBalance.WorldTownScreenHireDialogModule_createDIV.call(this, _parentDiv);
    if (MSU.getSettingValue(TrueBalance.ID, "Talents"))
    {
    this.mTrueBalance = {
        Grid : $('<div class="clever-recruiter-stats-grid"/>'),
        Properties : [
            {
                ID : "Hitpoints",
                IconAsset : Asset.ICON_HEALTH
            },
            {
                ID : "MeleeSkill",
                IconAsset : Asset.ICON_MELEE_SKILL
            },
            {
                ID : "Stamina",
                IconAsset : Asset.ICON_FATIGUE
            },
            {
                ID : "RangedSkill",
                IconAsset : Asset.ICON_RANGE_SKILL
            },
            {
                ID : "Bravery",
                IconAsset : Asset.ICON_BRAVERY
            },
            {
                ID : "MeleeDefense",
                IconAsset : Asset.ICON_MELEE_DEFENCE
            },
            {
                ID : "Initiative",
                IconAsset : Asset.ICON_INITIATIVE
            },
            {
                ID : "RangedDefense",
                IconAsset : Asset.ICON_RANGE_DEFENCE
            }
        ]
    }
    var row;
    var container;
    for (var i = 0; i < this.mTrueBalance.Properties.length; i++)
    {
        if (i % 2 == 0)
        {
            row = $('<div class="stat-row"/>');
            this.mTrueBalance.Grid.append(row);
        }
        container = $('<div class="stat-container"/>');
        row.append(container)
        container.append($('<img class="stat-icon" src="' + Path.GFX + this.mTrueBalance.Properties[i].IconAsset + '"/>'));
        this.mTrueBalance.Properties[i].Text = $('<div class="stat-text"/>');
        container.append(this.mTrueBalance.Properties[i].Text);
    }

    this.mDetailsPanel.CharacterBackgroundTextScrollContainer.before(this.mTrueBalance.Grid);
}
}

TrueBalance.WorldTownScreenHireDialogModule_updateDetailsPanel = WorldTownScreenHireDialogModule.prototype.updateDetailsPanel;
WorldTownScreenHireDialogModule.prototype.updateDetailsPanel = function (_element)
{
    TrueBalance.WorldTownScreenHireDialogModule_updateDetailsPanel.call(this, _element);
    if (_element === null || _element.length == 0) return;
    var data = _element.data('entry');
    var value;
    if (MSU.getSettingValue(TrueBalance.ID, "Talents"))
    {
        for (var i = 0; i < this.mTrueBalance.Properties.length; i++)
        {
            if (data['IsTryoutDone'])
            {
                value = data.Properties[this.mTrueBalance.Properties[i].ID][0]
            }
            else
            {
                value = "??" 
            }   
            this.mTrueBalance.Properties[i].Text.html(value); 
        }
    }
}